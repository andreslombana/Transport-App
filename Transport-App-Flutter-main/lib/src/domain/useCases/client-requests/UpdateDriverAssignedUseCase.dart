import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

@injectable
class UpdateDriverAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateDriverAssignedUseCase(this.clientRequestsRepository);

  run(int idClientRequest, int idDriver, double fareAssigned) => clientRequestsRepository.updateDriverAssigned(idClientRequest, idDriver, fareAssigned);

}