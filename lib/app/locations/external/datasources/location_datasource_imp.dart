import 'package:gamaapp/app/locations/domain/errors/error.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../infra/datasources/location_datasource.dart';

class LocationDatasourceImp implements LocationDatasource {
  @override
  Future<Placemark> getPlace(Position position) async {
    List<Placemark> places =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    return places.first;
  }

  @override
  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationEnabledError(message: "Serviço não habilitado");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionError(message: "Permissão negada");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionError(
          message: "Permissão negada permanentemente");
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
