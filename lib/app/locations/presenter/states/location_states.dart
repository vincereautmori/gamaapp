import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationStates {
  static Rx<Placemark?> place = Rx<Placemark?>(null);
  static Rx<Position?> position = Rx<Position?>(null);
}
