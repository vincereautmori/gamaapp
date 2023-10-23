import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';

abstract class LocationRepository {
  Future<Result<Position, Failure>> getPosition();
  Future<Result<Placemark, Failure>> getPlace(Position position);
}
