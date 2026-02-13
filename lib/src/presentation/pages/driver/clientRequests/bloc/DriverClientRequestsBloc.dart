import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/drivers-position/DriversPositionUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';

class DriverClientRequestsBloc extends Bloc<DriverClientRequestsEvent, DriverClientRequestsState> {

  final AuthUseCases authUseCases;
  final DriversPositionUseCases driversPositionUseCases;
  final ClientRequestsUseCases clientRequestsUseCases;
  final DriverTripRequestUseCases driverTripRequestUseCases;
  final BlocSocketIO blocSocketIO;

  DriverClientRequestsBloc({
    required this.blocSocketIO,
    required this.clientRequestsUseCases,
    required this.driversPositionUseCases,
    required this.authUseCases,
    required this.driverTripRequestUseCases,
  }) : super(DriverClientRequestsState()) {

    on<InitDriverClientRequest>((event, emit) async {
      final authResponse = await authUseCases.getUserSession.run();
      final responseDriverPosition = await driversPositionUseCases.getDriverPosition.run(authResponse.user.id!);

      // --- CORRECCIÓN 1: Limpieza Total del Estado ---
      // Emitimos un estado NUEVO, no una copia. Esto pone 'responseCreateDriverTripRequest' en null.
      emit(DriverClientRequestsState(
        response: Loading(),
        idDriver: authResponse.user.id!,
        responseDriverPosition: responseDriverPosition,
        // fareOffered se reinicia a vacío por defecto en el constructor
      ));

      // 1. Carga inicial
      add(GetNearbyTripRequest());
      
      // 2. Activar socket
      add(ListenNewClientRequestSocketIO());
    });

    on<GetNearbyTripRequest>((event, emit) async {
      if (state.response is! Success) {
         emit(state.copyWith(response: Loading()));
      }
      
      if (state.responseDriverPosition is! Success) return;
      final driverPosition = (state.responseDriverPosition as Success<DriverPosition>).data;

      if (driverPosition == null) return;

      final response = await clientRequestsUseCases.getNearbyTripRequest.run(
        driverPosition.lat,
        driverPosition.lng,
      );
      
      emit(state.copyWith(response: response));
    });

    on<CreateDriverTripRequest>((event, emit) async {
      emit(state.copyWith(responseCreateDriverTripRequest: Loading()));
      final response = await driverTripRequestUseCases.createDriverTripRequest.run(event.driverTripRequest);
      
      // Emitimos el resultado (Éxito o Error)
      emit(state.copyWith(responseCreateDriverTripRequest: response));
    });

    on<FareOfferedChange>((event, emit) {
      emit(state.copyWith(fareOffered: event.fareOffered));
    });

    on<ListenNewClientRequestSocketIO>((event, emit) async {
      var socket = blocSocketIO.state.socket;
      if (socket == null || !socket.connected) {
        blocSocketIO.add(ConnectSocketIO());
        await Future.delayed(const Duration(seconds: 2));
        if (!isClosed) add(ListenNewClientRequestSocketIO());
        return;
      }

      socket.off('created_request_client');
      socket.off('new_driver_assigned');
      
      socket.on('created_request_client', (data) {
        add(OnNewClientRequestReceived(data));
      });

      socket.on('new_driver_assigned', (data) {
         add(OnRemoveClientRequest(data));
      });
    });

    on<OnNewClientRequestReceived>((event, emit) {
      add(GetNearbyTripRequest());
    });

    on<OnRemoveClientRequest>((event, emit) {
      try {
        int? idToRemove;
        if (event.data is Map && event.data.containsKey('id_client_request')) {
           idToRemove = int.tryParse(event.data['id_client_request'].toString());
        } else if (event.data is int) {
           idToRemove = event.data;
        }
        
        if (idToRemove != null && state.response is Success) {
           List<ClientRequestResponse> currentList = List.from((state.response as Success).data);
           currentList.removeWhere((item) => item.id == idToRemove);
           emit(state.copyWith(response: Success(currentList)));
        }
      } catch (e) {
        print('Error removiendo solicitud: $e');
      }
    });

    on<EmitNewDriverOfferSocketIO>((event, emit) {
      blocSocketIO.state.socket?.emit('new_driver_offer', {'id_client_request': event.idClientRequest});
    });
  }
}