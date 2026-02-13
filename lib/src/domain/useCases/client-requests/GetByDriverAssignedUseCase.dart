import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

@injectable
class GetByDriverAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByDriverAssignedUseCase(this.clientRequestsRepository);

  run(int idDriver) => clientRequestsRepository.getByDriverAssigned(idDriver);

}