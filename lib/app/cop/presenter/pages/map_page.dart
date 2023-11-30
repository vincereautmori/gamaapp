import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gamaapp/app/ocurrences/presenter/controllers/occurrences_properties_controller.dart';
import 'package:gamaapp/shared/config/config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../shared/themes/palette.dart';
import '../../../locations/presenter/controllers/location_controller.dart';
import '../../../ocurrences/presenter/controllers/ocurrences_controller.dart';
import '../widgets/status_chips.dart';

class MapPage extends GetView<LocationController> {
  const MapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Position? position = controller.position;
    final OcurrencesController ocurrenceController =
        Get.find<OcurrencesController>();
    final OccurrencesPropertiesController propertiesController =
        Get.find<OccurrencesPropertiesController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          bool isOccurrenceStarted =
              ocurrenceController.startedOccurrence != null;
          return StatusChips(
            isInOccurence: isOccurrenceStarted,
            openOccurrenceAction: isOccurrenceStarted
                ? () => ocurrenceController
                    .viewOccurrence(ocurrenceController.startedOccurrence!.id)
                : null,
          );
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        List<Marker> markers = ocurrenceController.occurrences
            .map<Marker>(
              (ocurrence) => Marker(
                point: LatLng(ocurrence.latitude, ocurrence.longitude),
                anchorPos: AnchorPos.align(AnchorAlign.top),
                height: 40,
                width: 40,
                builder: (context) => IconButton(
                  onPressed: () => ocurrenceController
                      .viewOccurrence(ocurrence.occurrenceId),
                  icon: Icon(
                    Icons.place,
                    color: ocurrence.occurrenceId ==
                            ocurrenceController.startedOccurrence?.id
                        ? Palette.warning
                        : Palette.red,
                    size: 40,
                  ),
                ),
              ),
            )
            .toList();

        if (controller.isLocationLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return FlutterMap(
          options: MapOptions(
            zoom: 15.0,
            maxZoom: 22,
            center: LatLng(position?.latitude ?? -22.7467,
                position?.longitude ?? -47.3311),
          ),
          children: [
            TileLayer(
              urlTemplate: Config.mapBoxBaseUrl,
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                    position?.latitude ?? -22.7467,
                    position?.longitude ?? -47.3311,
                  ),
                  anchorPos: AnchorPos.align(AnchorAlign.center),
                  height: 40,
                  width: 40,
                  builder: (context) => const Icon(
                    Icons.radio_button_checked,
                    color: Palette.primary,
                    size: 40,
                  ),
                ),
                ...markers,
              ],
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: propertiesController.fetchProperties,
        icon: const Icon(PhosphorIcons.plus),
        label: const Text("Nova ocorrência"),
      ),
    );
  }
}
