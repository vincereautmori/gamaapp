import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/locations/domain/repositories/location_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';

import 'get_place_usecase.dart';

class GetPlaceUsecaseImp implements GetPlaceUsecase {
  final LocationRepository repository;

  GetPlaceUsecaseImp(this.repository);

  @override
  Future<Result<Placemark, Failure>> call(Position position) {
    return repository.getPlace(position);
  }
}
