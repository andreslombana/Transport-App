import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

@injectable
class GetByClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByClientRequestUseCase(this.clientRequestsRepository);

  run(int idClientRequest) => clientRequestsRepository.getByClientRequest(idClientRequest);

}