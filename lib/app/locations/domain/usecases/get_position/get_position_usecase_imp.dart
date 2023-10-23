import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/locations/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';

import 'get_position_usecase.dart';

class GetPositionUsecaseImp implements GetPositionUsecase {
  final LocationRepository repository;

  GetPositionUsecaseImp(this.repository);

  @override
  Future<Result<Position, Failure>> call() {
    return repository.getPosition();
  }
}
