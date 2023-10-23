import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class GetPlaceUsecase {
  Future<Result<Placemark, Failure>> call(Position position);
}
