import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';

class ClientDriverOffersBloc extends Bloc<ClientDriverOffersEvent, ClientDriverOffersState> {

  BlocSocketIO blocSocketIO;
  DriverTripRequestUseCases driverTripRequestUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  ClientDriverOffersBloc(this.blocSocketIO, this.driverTripRequestUseCases, this.clientRequestsUseCases): super(ClientDriverOffersState()) {
    
    on<GetDriverOffers>((event, emit) async {
      // Solo mostramos loading si no hay datos previos para evitar parpadeo feo, 
      // pero como ya limpiamos al inicio, esto funcionará bien.
      if (state.responseDriverOffers is! Success) {
         emit(state.copyWith(responseDriverOffers: Loading()));
      }
      Resource<List<DriverTripRequest>> response = await driverTripRequestUseCases.getDriverTripOffersByClientRequest.run(event.idClientRequest);
      emit(state.copyWith(responseDriverOffers: response));
    });

    on<ListenNewDriverOfferSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.off('created_driver_offer/${event.idClientRequest}');
        blocSocketIO.state.socket?.on('created_driver_offer/${event.idClientRequest}', (data) {
          add(GetDriverOffers(idClientRequest: event.idClientRequest));
        });
      }
    });

    on<AssignDriver>((event, emit) async {
      emit(state.copyWith(responseAssignDriver: Loading()));
      Resource<bool> response = await clientRequestsUseCases.updateDriverAssigned.run(event.idClientRequest, event.idDriver, event.fareAssigned);
      emit(state.copyWith(responseAssignDriver: response));
      
      if (response is Success) {
        add(EmitNewClientRequestSocketIO(idClientRequest: event.idClientRequest));
        add(EmitNewDriverAssignedSocketIO(idClientRequest: event.idClientRequest, idDriver: event.idDriver));
      }
    });

    on<EmitNewClientRequestSocketIO>((event, emit) {
      blocSocketIO.state.socket?.emit('new_client_request', {'id_client_request': event.idClientRequest});
    });

    on<EmitNewDriverAssignedSocketIO>((event, emit) {
      blocSocketIO.state.socket?.emit('new_driver_assigned', {'id_client_request': event.idClientRequest, 'id_driver': event.idDriver});
    });
    
    on<CancelRequest>((event, emit) async {
      await clientRequestsUseCases.cancelRequest.run(event.idClientRequest);
    });

    // --- AQUÍ ESTÁ LA LIMPIEZA ---
    // Cuando llamamos a este evento, el estado vuelve a ser virgen (Vacío)
    on<ClearDriverOffers>((event, emit) {
      emit(ClientDriverOffersState()); 
    });
  }
}