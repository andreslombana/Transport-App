import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

@injectable
class CancelRequestUseCase {
  final ClientRequestsRepository repository;
  CancelRequestUseCase(this.repository);

  Future<Resource<bool>> run(int idClientRequest) => repository.cancelRequest(idClientRequest);
}