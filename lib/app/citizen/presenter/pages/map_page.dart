import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gamaapp/app/citizen/presenter/controllers/map_controller.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends GetView<MapPageController> {
  const MapPage({
    super.key,
    this.latitude = -22.7467,
    this.longitude = -47.3311,
    this.canMove = true,
    this.initialMark,
  });
  final double latitude;
  final double longitude;
  final bool canMove;
  final MarkerLayer? initialMark;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 13.0,
        minZoom: 12.0,
        interactiveFlags: canMove ? InteractiveFlag.all : InteractiveFlag.none,
        center: LatLng(latitude, longitude),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        initialMark ?? const SizedBox()
      ],
    );
  }
}
