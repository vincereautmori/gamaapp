import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/themes/palette.dart';
import '../../../../../shared/widgets/mapbox_map.dart';
import '../../../ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import '../../../ocurrences/presenter/controllers/ocurrences_controller.dart';

class ViewOcurrencePage extends GetView<OccurrencesController> {
  const ViewOcurrencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ocorrência'),
        foregroundColor: Palette.white,
        backgroundColor: Palette.primary,
      ),
      body: Obx(
        () {
          OccurrencesInfo? occurrence = controller.openedOccurrence;
          if (occurrence == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => controller.refreshOccurrence(occurrence.id),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                          color: Palette.greyBackground,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Nº Ocorrência",
                                style: TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "#${occurrence.id}",
                                style: const TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
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
                              const Text(
                                "Ocorrência",
                                style: TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                occurrence.name,
                                style: const TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
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
                              const Text(
                                "Situação",
                                style: TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                occurrence.active ? "Ativa" : "Inativa",
                                style: const TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
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
                              const Text(
                                "Status",
                                style: TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                occurrence.status,
                                style: const TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
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
                              const Text(
                                "Tipo",
                                style: TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                occurrence.occurrenceType,
                                style: const TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
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
                              const Text(
                                "Urgência",
                                style: TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                occurrence.urgencyLevel,
                                style: const TextStyle(
                                  color: Palette.darkGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Ink(
                          color: Palette.greyBackground,
                          child: InkWell(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            onTap: occurrence.imageUrl.isEmpty
                                ? null
                                : () async {
                                    await Future.wait([
                                      controller.loadImage(occurrence.imageUrl),
                                      Get.dialog(
                                        Obx(
                                          () {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: Get.back,
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Palette.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: controller
                                                            .loadedImage.isEmpty
                                                        ? const CircularProgressIndicator(
                                                            color:
                                                                Palette.white,
                                                          )
                                                        : Image.memory(
                                                            Uint8List.fromList(
                                                              controller
                                                                  .loadedImage,
                                                            ),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                48,
                                                            frameBuilder: (context,
                                                                child,
                                                                frame,
                                                                wasSynchronouslyLoaded) {
                                                              if (wasSynchronouslyLoaded) {
                                                                return child;
                                                              }
                                                              return AnimatedSwitcher(
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            200),
                                                                child: frame !=
                                                                        null
                                                                    ? child
                                                                    : SizedBox(
                                                                        width: MediaQuery.of(context).size.width -
                                                                            48,
                                                                        height:
                                                                            500,
                                                                        child: Shimmer.fromColors(
                                                                            baseColor: Colors.grey.shade300,
                                                                            highlightColor: Colors.grey.shade100,
                                                                            child: Container(
                                                                              width: double.infinity,
                                                                              height: 500.0,
                                                                              margin: const EdgeInsets.all(16.0),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                                color: Colors.white,
                                                                              ),
                                                                            )),
                                                                      ),
                                                              );
                                                            },
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ).then((_) =>
                                          controller.loadedImage.clear()),
                                    ]);
                                  },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Imagem",
                                    style: TextStyle(
                                      color: Palette.darkGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    occurrence.imageUrl.isEmpty
                                        ? "Sem imagem"
                                        : "Visualizar",
                                    style: const TextStyle(
                                      color: Palette.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Descrição",
                    style: Texts.subtitle,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Palette.greyBackground,
                    ),
                    child: Text(occurrence.description, softWrap: true),
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
                              "https://www.google.com/maps/search/?api=1&query=${occurrence.latitude},${occurrence.longitude}";
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
                    height: 160,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: MapboxMap(
                      latitude: occurrence.latitude,
                      longitude: occurrence.longitude,
                      canMove: false,
                      initialMark: MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              occurrence.latitude,
                              occurrence.longitude,
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
                        "${occurrence.latitude}",
                        style: Texts.subtitle.copyWith(
                          fontSize: 14,
                          color: Palette.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${occurrence.longitude}",
                        style: Texts.subtitle.copyWith(
                          fontSize: 14,
                          color: Palette.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (occurrence.status != "Atendimento concluído")
                    GamaButton(
                      text: controller.startedOccurrence?.id == occurrence.id
                          ? "Finalizar Ocorrência"
                          : "Iniciar Ocorrência",
                      onPressed:
                          controller.startedOccurrence?.id == occurrence.id
                              ? () => controller.stop(occurrence.id)
                              : () => controller.start(occurrence),
                      backgroundColor:
                          controller.startedOccurrence?.id == occurrence.id
                              ? Palette.red
                              : Palette.primary,
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
