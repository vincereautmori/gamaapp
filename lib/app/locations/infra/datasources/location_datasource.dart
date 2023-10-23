import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationDatasource {
  Future<Position> getPosition();
  Future<Placemark> getPlace(Position position);
}
