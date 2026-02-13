import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/CreateClientRequestUseCase.dart';
// Asegúrate de que este archivo exista y se llame así (Mayúscula G)
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetTimeAndDistanceUseCase.dart'; 
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetNearbyTripRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateDriverAssignedUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateStatusClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateClientRatingUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/UpdateDriverRatingUseCase.dart';
// Import corregido (sin ' copy')
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByClientAssignedUseCase.dart'; 
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetByDriverAssignedUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/CancelRequestUseCase.dart';

@injectable
class ClientRequestsUseCases {
  final CreateClientRequestUseCase createClientRequest;
  final GetTimeAndDistanceUseCase getTimeAndDistance;
  final GetNearbyTripRequestUseCase getNearbyTripRequest;
  final UpdateDriverAssignedUseCase updateDriverAssigned;
  final GetByClientRequestUseCase getByClientRequest;
  final UpdateStatusClientRequestUseCase updateStatusClientRequest;
  final UpdateClientRatingUseCase updateClientRating;
  final UpdateDriverRatingUseCase updateDriverRating;
  final GetByClientAssignedUseCase getByClientAssigned;
  final GetByDriverAssignedUseCase getByDriverAssigned;
  final CancelRequestUseCase cancelRequest;

  ClientRequestsUseCases({
    required this.createClientRequest,
    required this.getTimeAndDistance,
    required this.getNearbyTripRequest,
    required this.updateDriverAssigned,
    required this.getByClientRequest,
    required this.updateStatusClientRequest,
    required this.updateClientRating,
    required this.updateDriverRating,
    required this.getByClientAssigned,
    required this.getByDriverAssigned,
    required this.cancelRequest,
  });
}