import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/app/cop/presenter/widgets/violations_bottom_sheet.dart';
import 'package:gamaapp/app/locations/presenter/controllers/location_controller.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:gamaapp/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/widgets/square_line.dart';
import '../../controllers/cop_traffic_violation_controller.dart';
import '../../formatters/placa_formatter.dart';

class NewTrafficFinePage extends GetView<CopTrafficFineController> {
  const NewTrafficFinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CopTrafficViolationController violationsController = Get.find();
    LocationController locationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar multa'),
        foregroundColor: Palette.white,
        backgroundColor: Palette.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Palette.primary,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Palette.white,
                    ),
                    textColor: Palette.white,
                    title: const Text(
                      'Hora da multa',
                    ),
                    subtitle: Text(
                      DateTime.now().formatDate('dd/MM/yy - HH:mm:ss')!,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ListTile(
                    leading: const Icon(
                      Icons.map_outlined,
                      color: Palette.white,
                    ),
                    textColor: Palette.white,
                    title: const Text(
                      'Local da multa',
                    ),
                    subtitle: Obx(() => Text(
                          locationController.place?.street ??
                              "Carregando localização...",
                        )),
                  ),
                  const SizedBox(height: 4),
                  const ListTile(
                    leading: Icon(
                      Icons.person_pin_outlined,
                      color: Palette.white,
                    ),
                    textColor: Palette.white,
                    title: Text(
                      'Oficial responsável',
                    ),
                    subtitle: Text(
                      "Policial Dev",
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SquaresLines(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GamaTextField(
                controller: controller.licensePlateCreate,
                label: 'Placa',
                placeholder: "Informe o número da placa",
                masks: [GamaPlacaVeiculoInputFormatter()],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Palette.greyBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.photo_outlined,
                        ),
                      ),
                      onTap: controller.imageBytesCount == 0
                          ? controller.uploadImage
                          : !controller.isUploading
                              ? () {
                                  Get.dialog(
                                    Column(
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
                                          child: Obx(() => Center(
                                                child: controller
                                                        .loadedImage.isEmpty
                                                    ? const CircularProgressIndicator(
                                                        color: Palette.white,
                                                      )
                                                    : Image.memory(
                                                        Uint8List.fromList(
                                                          controller
                                                              .loadedImage,
                                                        ),
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
                                                            child: frame != null
                                                                ? child
                                                                : SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        48,
                                                                    height: 500,
                                                                    child: Shimmer.fromColors(
                                                                        baseColor: Colors.grey.shade300,
                                                                        highlightColor: Colors.grey.shade100,
                                                                        child: Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              500.0,
                                                                          margin: const EdgeInsets
                                                                              .all(
                                                                              16.0),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0),
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        )),
                                                                  ),
                                                          );
                                                        },
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            48,
                                                      ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              : null,
                      title: Text(
                        controller.imageBytesCount == 0
                            ? 'Nenhuma imagem'
                            : controller.isUploading
                                ? "Carregando..."
                                : "Imagem carregada!",
                      ),
                      trailing: controller.imageBytesCount == 0
                          ? const Icon(Icons.add)
                          : controller.isUploading
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Palette.primary,
                                    value: controller.imageBytesCount /
                                        controller.imageBytesTotal,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.check),
                    )),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Palette.lightGrey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Infrações',
                    style: Texts.cardTitle,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      violationsController.getAllViolations();
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const ViolationsBottomSheet());
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar infração'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (violationsController.selectedTrafficViolations.isEmpty) {
                return const Center(
                  child: Text("Nenhuma infração selecionada"),
                );
              }

              return Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 8,
                children: List.from(
                  violationsController.selectedTrafficViolations.map(
                    (violation) {
                      return Chip(
                        label: Text(violation.name),
                        onDeleted: () {
                          violationsController.unselectViolation(violation);
                        },
                        labelStyle: const TextStyle(color: Palette.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Palette.primary),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () {
          bool isDisabled = controller.isCreateLoading ||
              violationsController.selectedTrafficViolations.isEmpty ||
              controller.licensePlateCreate.text.isEmpty;
          return FloatingActionButton.extended(
            backgroundColor: isDisabled ? Palette.lightGrey : null,
            foregroundColor: isDisabled ? Palette.grey : null,
            onPressed: isDisabled ? null : controller.addTrafficFine,
            icon: controller.isCreateLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Palette.white,
                      strokeWidth: 2,
                    ))
                : const Icon(Icons.save_outlined),
            label: Text(
              controller.isCreateLoading ? "Gravando..." : 'Gravar multa',
            ),
          );
        },
      ),
    );
  }
}
