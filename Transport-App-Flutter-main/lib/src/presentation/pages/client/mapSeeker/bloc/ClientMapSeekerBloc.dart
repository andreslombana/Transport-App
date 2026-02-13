import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIOEvent.dart'; // Asegúrate de importar esto
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';

class ClientMapSeekerBloc extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {

  GeolocatorUseCases geolocatorUseCases;
  SocketUseCases socketUseCases;
  BlocSocketIO blocSocketIO;
  
  ClientMapSeekerBloc(this.blocSocketIO, this.geolocatorUseCases, this.socketUseCases): super(ClientMapSeekerState()) {
    
    on<ClientMapSeekerInitEvent>((event, emit) {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });
    
    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      emit(state.copyWith(position: position));
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController = await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 15, // Zoom un poco más cerca para ver mejor
            bearing: 0
          )
        ));
      } catch (e) {
        print('ERROR EN ChangeMapCameraPosition: $e');
      }
    }); 

    on<OnCameraMove>((event, emit) {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });

    on<OnCameraIdle>((event, emit) async {
      try {
        PlacemarkData placemarkData = await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
        emit(state.copyWith(placemarkData: placemarkData));  
      } catch (e) {
        print('OnCameraIdle Error: $e');
      }
    });

    on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(state.copyWith(
        pickUpLatLng: LatLng(event.lat, event.lng),
        pickUpDescription: event.pickUpDescription
      ));
      add(SetAddressMarkers());
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(state.copyWith(
        destinationLatLng: LatLng(event.lat, event.lng),
        destinationDescription: event.destinationDescription
      ));
      add(SetAddressMarkers());
    });

    on<SetAddressMarkers>((event, emit) async {
      final updatedMarkers = Map.of(state.markers);
      if (state.pickUpLatLng != null && state.pickUpDescription.isNotEmpty) {
          BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker.run('assets/img/person_location.png');
          Marker markerPickUp = geolocatorUseCases.getMarker.run(
              'pickup_seeker', state.pickUpLatLng!.latitude, state.pickUpLatLng!.longitude,
              'Lugar de recogida', state.pickUpDescription, pickUpDescriptor
          );
          updatedMarkers[markerPickUp.markerId] = markerPickUp;
      }
      if (state.destinationLatLng != null && state.destinationDescription.isNotEmpty) {
          BitmapDescriptor destinationDescriptor = await geolocatorUseCases.createMarker.run('assets/img/red_flag.png');
          Marker markerDestination = geolocatorUseCases.getMarker.run(
              'destination_seeker', state.destinationLatLng!.latitude, state.destinationLatLng!.longitude,
              'Lugar de destino', state.destinationDescription, destinationDescriptor
          );
          updatedMarkers[markerDestination.markerId] = markerDestination;
      }
      emit(state.copyWith(markers: updatedMarkers));
    });

    on<ListenDriversPositionSocketIO>((event, emit) async {
      if (blocSocketIO.state.socket != null ) {
        blocSocketIO.state.socket?.on('new_driver_position', (data) {
          add(AddDriverPositionMarker(
              idSocket: data['id_socket'] as String, 
              id: data['id'] as int, 
              lat: data['lat'] as double, 
              lng: data['lng'] as double
          ));
        });
      }
    });

    on<ListenDriversDisconnectedSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null ) {
        blocSocketIO.state.socket?.on('driver_disconnected', (data) {
          add(RemoveDriverPositionMarker(idSocket: data['id_socket'] as String));
        });
      }
    });

    on<RemoveDriverPositionMarker>((event, emit) {
      emit(state.copyWith(markers: Map.of(state.markers)..remove(MarkerId(event.idSocket))));
    });

    on<AddDriverPositionMarker>((event, emit) async {
      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        event.idSocket, event.lat, event.lng, 'Conductor disponible', '', descriptor
      );
      emit(state.copyWith(markers: Map.of(state.markers)..[marker.markerId] = marker));
    });

    // =====================================================================
    // NUEVA LÓGICA: ESCUCHAR OFERTAS DE CONDUCTORES
    // =====================================================================
    
    on<ListenDriverOffersSocketIO>((event, emit) {
      print('🏁 CLIENTE: Preparando escucha de ofertas para Solicitud ID: ${event.idClientRequest}');
      
      var socket = blocSocketIO.state.socket;
      
      // Verificación básica de conexión
      if (socket == null || !socket.connected) {
         print('⚠️ CLIENTE: Socket no conectado. Intentando conectar...');
         blocSocketIO.add(ConnectSocketIO());
      }

      // El nombre del evento es dinámico: created_driver_offer/83
      String eventName = 'created_driver_offer/${event.idClientRequest}';
      
      if (socket != null) {
         socket.off(eventName); // Limpiamos listener anterior para evitar duplicados
         
         print('👂 CLIENTE: Escuchando canal "$eventName"...');
         
         socket.on(eventName, (data) {
            print('💰💰💰 CLIENTE: ¡OFERTA RECIBIDA! 💰💰💰');
            print('Data: $data');
            add(OnNewDriverOfferReceived(data));
         });
      }
    });

    on<OnNewDriverOfferReceived>((event, emit) {
       // AQUÍ ACTUALIZAS TU ESTADO PARA MOSTRAR LA OFERTA EN LA UI
       // Ejemplo:
       // List<DriverOffer> currentOffers = List.from(state.offers);
       // currentOffers.add(DriverOffer.fromJson(event.data));
       // emit(state.copyWith(offers: currentOffers));
       
       print('Procesando oferta para mostrar en pantalla...');
    });

  }
}