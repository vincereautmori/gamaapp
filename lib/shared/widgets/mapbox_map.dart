import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../config/config.dart';

class MapboxMap extends StatelessWidget {
  const MapboxMap({
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
        zoom: 15.0,
        interactiveFlags: canMove ? InteractiveFlag.all : InteractiveFlag.none,
        center: LatLng(latitude, longitude),
      ),
      children: [
        TileLayer(
          urlTemplate: Config.mapBoxBaseUrl,
        ),
        initialMark ?? const SizedBox()
      ],
    );
  }
}
