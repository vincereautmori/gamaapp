import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/themes/palette.dart';
import '../../../../../shared/widgets/mapbox_map.dart';
import '../../../ocurrences/presenter/controllers/ocurrences_controller.dart';

class ViewOcurrencePage extends GetView<OcurrencesController> {
  const ViewOcurrencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ocorrência'),
          foregroundColor: Palette.white,
          backgroundColor: Palette.primary,
        ),
        body: Obx(() {
          OcurrencesInfo? ocurrence = controller.openedOcurrence;
          if (ocurrence == null) {
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
                            const Text(
                              "Nº Ocorrência",
                              style: TextStyle(
                                color: Palette.darkGrey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "#${ocurrence.occurrenceId}",
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
                              ocurrence.occurrenceName,
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
                              "Situação",
                              style: TextStyle(
                                color: Palette.darkGrey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ocurrence.active ? "Ativa" : "Inativa",
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
                              "Aberto em",
                              style: TextStyle(
                                color: Palette.darkGrey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ocurrence.createdAt
                                      .formatDate("dd/MM/yyyy - HH:mm") ??
                                  "",
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
                              ocurrence.statusName,
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
                              "Tipo",
                              style: TextStyle(
                                color: Palette.darkGrey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ocurrence.occurrenceTypeName,
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
                              ocurrence.occurrenceUrgencyLevelName,
                              style: const TextStyle(
                                color: Palette.darkGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Ink(
                      //   color: Palette.greyBackground,
                      //   child: InkWell(
                      //     borderRadius: const BorderRadius.only(
                      //         bottomLeft: Radius.circular(8),
                      //         bottomRight: Radius.circular(8)),
                      //     onTap: ocurrence.imageUrl.isEmpty
                      //         ? null
                      //         : () async {
                      //             await Future.wait([
                      //               controller.loadImage(ocurrence.imageUrl),
                      //               Get.dialog(
                      //                 Obx(
                      //                   () {
                      //                     return Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.center,
                      //                       children: [
                      //                         Align(
                      //                           alignment: Alignment.topRight,
                      //                           child: IconButton(
                      //                             onPressed: Get.back,
                      //                             icon: const Icon(
                      //                               Icons.close,
                      //                               color: Palette.white,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         Expanded(
                      //                           child: Center(
                      //                             child: controller
                      //                                     .loadedImage.isEmpty
                      //                                 ? const CircularProgressIndicator(
                      //                                     color: Palette.white,
                      //                                   )
                      //                                 : Image.memory(
                      //                                     Uint8List.fromList(
                      //                                       controller
                      //                                           .loadedImage,
                      //                                     ),
                      //                                     width: MediaQuery.of(
                      //                                                 context)
                      //                                             .size
                      //                                             .width -
                      //                                         48,
                      //                                     frameBuilder: (context,
                      //                                         child,
                      //                                         frame,
                      //                                         wasSynchronouslyLoaded) {
                      //                                       if (wasSynchronouslyLoaded) {
                      //                                         return child;
                      //                                       }
                      //                                       return AnimatedSwitcher(
                      //                                         duration:
                      //                                             const Duration(
                      //                                                 milliseconds:
                      //                                                     200),
                      //                                         child: frame !=
                      //                                                 null
                      //                                             ? child
                      //                                             : SizedBox(
                      //                                                 width: MediaQuery.of(context)
                      //                                                         .size
                      //                                                         .width -
                      //                                                     48,
                      //                                                 height:
                      //                                                     500,
                      //                                                 child: Shimmer.fromColors(
                      //                                                     baseColor: Colors.grey.shade300,
                      //                                                     highlightColor: Colors.grey.shade100,
                      //                                                     child: Container(
                      //                                                       width:
                      //                                                           double.infinity,
                      //                                                       height:
                      //                                                           500.0,
                      //                                                       margin:
                      //                                                           const EdgeInsets.all(16.0),
                      //                                                       decoration:
                      //                                                           BoxDecoration(
                      //                                                         borderRadius: BorderRadius.circular(12.0),
                      //                                                         color: Colors.white,
                      //                                                       ),
                      //                                                     )),
                      //                                               ),
                      //                                       );
                      //                                     },
                      //                                   ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     );
                      //                   },
                      //                 ),
                      //               ).then(
                      //                   (_) => controller.loadedImage.clear()),
                      //             ]);
                      //           },
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 24.0,
                      //         vertical: 16,
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           const Text(
                      //             "Imagem",
                      //             style: TextStyle(
                      //               color: Palette.darkGrey,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //           Text(
                      //             ocurrence.imageUrl.isEmpty
                      //                 ? "Sem imagem"
                      //                 : "Visualizar",
                      //             style: const TextStyle(
                      //               color: Palette.primary,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                            "https://www.google.com/maps/search/?api=1&query=${ocurrence.latitude},${ocurrence.longitude}";
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
                    latitude: ocurrence.latitude,
                    longitude: ocurrence.longitude,
                    canMove: false,
                    initialMark: MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            ocurrence.latitude,
                            ocurrence.longitude,
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
                      "${ocurrence.latitude}",
                      style: Texts.subtitle.copyWith(
                        fontSize: 14,
                        color: Palette.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${ocurrence.longitude}",
                      style: Texts.subtitle.copyWith(
                        fontSize: 14,
                        color: Palette.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }));
  }
}
