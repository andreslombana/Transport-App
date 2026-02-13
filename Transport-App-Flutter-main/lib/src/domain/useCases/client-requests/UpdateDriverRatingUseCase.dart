import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

@injectable
class UpdateDriverRatingUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateDriverRatingUseCase(this.clientRequestsRepository);

  run(int idClientRequest, double rating) => clientRequestsRepository.updateDriverRating(idClientRequest, rating);

}