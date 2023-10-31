import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:gamaapp/app/citizen/presenter/pages/map_page.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/app/cop/presenter/widgets/licensePlates/mercosul_license_plate.dart';
import 'package:gamaapp/app/cop/presenter/widgets/licensePlates/old_license_plate.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/themes/palette.dart';
import '../../../domain/entities/trafficFine/traffic_fine_info.dart';

class ViewTrafficFinePage extends GetView<CopTrafficFineController> {
  const ViewTrafficFinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          foregroundColor: Palette.white,
          backgroundColor: Palette.primary,
        ),
        body: Obx(() {
          TrafficFineInfo? trafficFine = controller.trafficFine;
          if (trafficFine == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: trafficFine.licensePlate.contains('-')
                      ? OldLicensePlate(licensePlate: trafficFine.licensePlate)
                      : MercosulLicensePlate(
                          licensePlate: trafficFine.licensePlate,
                        ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Informações",
                  style: Texts.subtitle,
                ),
                const SizedBox(height: 8),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Palette.lightGrey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Situação"),
                            Text(trafficFine.active ? "Ativa" : "Inativa")
                          ],
                        ),
                      ),
                      Container(
                        color: Palette.greyBackground,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Aberto em"),
                            Text(trafficFine.createdAt
                                    .formatDate("dd/MM/yyyy - HH:mm") ??
                                "")
                          ],
                        ),
                      ),
                      Container(
                        color: Palette.lightGrey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Integração"),
                            Text(trafficFine.computed == true
                                ? "Computado"
                                : "Não computado")
                          ],
                        ),
                      ),
                      Container(
                        color: Palette.greyBackground,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Imagem"),
                            Text("trafficFine.imageUrl")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Localização",
                      style: Texts.subtitle,
                    ),
                    TextButton(
                      child: const Text("Ver no Google Maps"),
                      onPressed: () async {
                        String urlMap =
                            "https://www.google.com/maps/search/?api=1&query=${trafficFine.latitude},${trafficFine.longitude}";
                        if (await canLaunchUrl(Uri.parse(urlMap))) {
                          await launchUrl(Uri.parse(urlMap));
                        } else {
                          throw 'Could not launch Maps';
                        }
                      },
                    )
                  ],
                ),
                Container(
                  height: 184,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: MapPage(
                    latitude: trafficFine.latitude,
                    longitude: trafficFine.longitude,
                    canMove: false,
                    initialMark: MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            trafficFine.latitude,
                            trafficFine.longitude,
                          ),
                          anchorPos: AnchorPos.align(AnchorAlign.top),
                          height: 40,
                          width: 40,
                          builder: (context) => const Icon(
                            Icons.place,
                            color: Palette.red,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "${trafficFine.latitude}",
                      style: Texts.subtitle.copyWith(
                        fontSize: 14,
                        color: Palette.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${trafficFine.longitude}",
                      style: Texts.subtitle.copyWith(
                        fontSize: 14,
                        color: Palette.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
