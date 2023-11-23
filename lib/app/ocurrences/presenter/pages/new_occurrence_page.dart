import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/themes/palette.dart';
import '../../../../shared/themes/text_theme.dart';
import '../../../../shared/widgets/square_line.dart';
import '../../../../shared/widgets/textfield.dart';
import '../../../locations/presenter/controllers/location_controller.dart';
import '../../domain/entities/properties/properties_info.dart';
import '../controllers/ocurrences_controller.dart';

class NewOccurrencePage extends GetView<OcurrencesController> {
  const NewOccurrencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationController locationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar ocorrência'),
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
                      'Hora da ocorrência',
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
                      'Local da ocorrência',
                    ),
                    subtitle: Obx(() => Text(
                          locationController.place?.street ??
                              "Carregando localização...",
                        )),
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
                label: 'Título',
                placeholder: "Dê uma breve descrição da ocorrência",
                onChange: controller.setOccurrenceTitle,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Autocomplete<PropertiesInfo>(
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                      hintText: 'Selecione o tipo da ocorrência',
                    ),
                    onFieldSubmitted: (_) => onFieldSubmitted(),
                  );
                },
                onSelected: (type) => controller.setType(type.id),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return controller.occurrenceTypes
                      .where((PropertiesInfo option) {
                    return option.name
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Urgência",
                    style: Texts.subtitle,
                  ),
                  Obx(() => ToggleButtons(
                        onPressed: (int index) {
                          controller.setUrgencyLevel(index + 1);
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        isSelected: [1, 2, 3]
                            .map<bool>((id) =>
                                controller
                                    .occurrenceInput.occurrenceUrgencyLevelId ==
                                id)
                            .toList(),
                        children: const [
                          Icon(
                            PhosphorIcons.caret_double_down_bold,
                            color: Palette.primary,
                          ),
                          Icon(
                            PhosphorIcons.equals_bold,
                            color: Palette.grey,
                          ),
                          Icon(
                            PhosphorIcons.caret_double_up_bold,
                            color: Palette.red,
                          ),
                        ],
                      )),
                ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GamaTextField(
                label: "Descrição",
                placeholder: "Dê mais detalhes sobre o ocorrido",
                maxLines: 5,
                onChange: controller.setOccurrenceDescription,
              ),
            ),
            const SizedBox(height: 88),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () {
          bool isDisabled = controller.isCreateLoading;
          return FloatingActionButton.extended(
            backgroundColor: isDisabled ? Palette.lightGrey : null,
            foregroundColor: isDisabled ? Palette.grey : null,
            onPressed: isDisabled ? null : controller.newOccurrence,
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
              controller.isCreateLoading ? "Gravando..." : 'Gravar ocorrência',
            ),
          );
        },
      ),
    );
  }
}