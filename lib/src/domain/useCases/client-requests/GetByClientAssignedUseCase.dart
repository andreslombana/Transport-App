import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

@injectable
class GetByClientAssignedUseCase {
  final ClientRequestsRepository repository;

  GetByClientAssignedUseCase(this.repository);

  Future<Resource<List<ClientRequestResponse>>> run(int idClient) => repository.getByClientAssigned(idClient);
}