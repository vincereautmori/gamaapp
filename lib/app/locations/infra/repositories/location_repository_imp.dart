import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/locations/domain/errors/error.dart';
import 'package:gamaapp/app/locations/infra/datasources/location_datasource.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImp implements LocationRepository {
  final LocationDatasource datasource;

  LocationRepositoryImp(this.datasource);

  @override
  Future<Result<Placemark, Failure>> getPlace(Position position) async {
    try {
      Placemark place = await datasource.getPlace(position);
      return Success(place);
    } catch (e) {
      return Error(
        InvalidLocationError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<Position, Failure>> getPosition() async {
    try {
      Position position = await datasource.getPosition();
      return Success(position);
    } catch (e) {
      return Error(
        InvalidLocationError(
          message: e.toString(),
        ),
      );
    }
  }
}
