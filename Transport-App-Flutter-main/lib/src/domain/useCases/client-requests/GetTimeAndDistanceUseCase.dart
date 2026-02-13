import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

@injectable
class GetTimeAndDistanceUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetTimeAndDistanceUseCase(this.clientRequestsRepository);

  run(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) => clientRequestsRepository.getTimeAndDistanceClientRequets(originLat, originLng, destinationLat, destinationLng);

}