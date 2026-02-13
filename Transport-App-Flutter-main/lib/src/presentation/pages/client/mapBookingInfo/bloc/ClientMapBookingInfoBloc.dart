import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

class ClientMapBookingInfoBloc
    extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {
  GeolocatorUseCases geolocatorUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  AuthUseCases authUseCases;
  BlocSocketIO blocSocketIO;

  ClientMapBookingInfoBloc(
    this.blocSocketIO,
    this.geolocatorUseCases,
    this.clientRequestsUseCases,
    this.authUseCases,
  ) : super(ClientMapBookingInfoState()) {
    on<ClientMapBookingInfoInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(state.copyWith(
        pickUpLatLng: event.pickUpLatLng,
        destinationLatLng: event.destinationLatLng,
        pickUpDescription: event.pickUpDescription,
        destinationDescription: event.destinationDescription,
        controller: controller,
      ));

      BitmapDescriptor pickUpDescriptor =
          await geolocatorUseCases.createMarker.run('assets/img/pin_white.png');
      BitmapDescriptor destinationDescriptor =
          await geolocatorUseCases.createMarker.run('assets/img/flag.png');

      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        'Lugar de recogida',
        'Debes permanecer aquí mientras llega el conductor',
        pickUpDescriptor,
      );

      Marker markerDestination = geolocatorUseCases.getMarker.run(
        'destination',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        'Tu Destino',
        '',
        destinationDescriptor,
      );

      emit(state.copyWith(markers: {
        markerPickUp.markerId: markerPickUp,
        markerDestination.markerId: markerDestination,
      }));
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController googleMapController = await state.controller!.future;
      await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(event.lat, event.lng), zoom: 12, bearing: 0),
      ));
    });

    on<FareOfferedChanged>((event, emit) {
      emit(state.copyWith(fareOffered: BlocFormItem(
        value: event.fareOffered.value,
        error: event.fareOffered.value.isEmpty ? 'Ingresa la tarifa' : null,
      )));
    });

    // FIX DEFINITIVO: conversión segura de string a double
    on<CreateClientRequest>((event, emit) async {
      try {
        AuthResponse authResponse = await authUseCases.getUserSession.run();

        final fareString = state.fareOffered.value.trim();
        final double fareOffered = fareString.isEmpty
            ? 15000.0
            : (double.tryParse(fareString) ?? 15000.0);

        Resource<int> response = await clientRequestsUseCases.createClientRequest.run(
          ClientRequest(
            idClient: authResponse.user.id!,
            fareOffered: fareOffered,
            pickupDescription: state.pickUpDescription ?? '',
            destinationDescription: state.destinationDescription ?? '',
            pickupLat: state.pickUpLatLng!.latitude,
            pickupLng: state.pickUpLatLng!.longitude,
            destinationLat: state.destinationLatLng!.latitude,
            destinationLng: state.destinationLatLng!.longitude,
          ),
        );

        // Emitir evento Socket.IO solo si se creó correctamente
        if (response is Success) {
           final id = response.data;
           if (id != null) {
             add(EmitNewClientRequestSocketIO(idClientRequest: id));
           }
        }

        emit(state.copyWith(responseClientRequest: response));
      } catch (e) {
        print('Error creando solicitud: $e');
        emit(state.copyWith(
          responseClientRequest: ErrorData('Error al crear la solicitud'),
        ));
      }
    });

    on<EmitNewClientRequestSocketIO>((event, emit) {
      if (blocSocketIO.state.socket?.connected ?? false) {
        blocSocketIO.state.socket?.emit('new_client_request', {
          'id_client_request': event.idClientRequest,
        });
      }
    });

    on<GetTimeAndDistanceValues>((event, emit) async {
      emit(state.copyWith(responseTimeAndDistance: Loading()));
      Resource<TimeAndDistanceValues> response =
          await clientRequestsUseCases.getTimeAndDistance.run(
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
      );
      emit(state.copyWith(responseTimeAndDistance: response));
    });

    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline.run(
        state.pickUpLatLng!,
        state.destinationLatLng!,
      );

      PolylineId id = const PolylineId("MyRoute");
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 6,
      );

      emit(state.copyWith(polylines: {id: polyline}));
    });
  }
}