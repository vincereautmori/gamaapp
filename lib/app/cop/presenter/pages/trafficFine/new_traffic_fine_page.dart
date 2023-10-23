import 'package:flutter/material.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:gamaapp/shared/extensions/set_extension.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:gamaapp/shared/widgets/textfield.dart';
import 'package:get/get.dart';

import '../../../../../shared/widgets/square_line.dart';
import '../../../domain/entities/trafficViolations/traffic_violation_info.dart';
import '../../controllers/cop_traffic_violation_controller.dart';
import '../../formatters/placa_formatter.dart';

class NewTrafficFinePage extends GetView<CopTrafficFineController> {
  const NewTrafficFinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CopTrafficViolationController violationsController = Get.find();

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
                      'Hora da ocorrência',
                    ),
                    subtitle: Text(
                      DateTime.now().formatDate('dd/MM/yy - hh:mm:ss')!,
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
                    subtitle: Text(
                      DateTime.now().formatDate('dd/MM/yy - hh:mm:ss')!,
                    ),
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
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.photo_outlined,
                    ),
                  ),
                  onTap: controller.uploadImage,
                  title: const Text('Nenhuma imagem'),
                  trailing: Obx(() {
                    if (controller.imageBytesCount == 0) {
                      return const Icon(Icons.add);
                    }

                    if (controller.isUploading) {
                      return SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Palette.primary,
                          value: controller.imageBytesCount /
                              controller.imageBytesTotal,
                          strokeWidth: 2,
                        ),
                      );
                    }

                    return const Icon(Icons.check);
                  }),
                ),
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
                        builder: (context) => BottomSheet(
                          enableDrag: false,
                          showDragHandle: true,
                          onClosing: () {},
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Clique na infração"),
                                ListView.builder(
                                  itemCount: violationsController
                                      .trafficViolations.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    TrafficViolationInfo violation =
                                        violationsController
                                            .trafficViolations[index];
                                    return ListTile(
                                      leading: Text(violation.code),
                                      title: Text(violation.name),
                                      onTap: () {
                                        violationsController
                                            .selectViolation(violation);
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar infração'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount:
                    violationsController.selectedTrafficViolations.length,
                itemBuilder: (context, index) {
                  TrafficViolationInfo violation =
                      violationsController.selectedTrafficViolations[index];
                  return ListTile(
                    title: Text(violation.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => violationsController.unselectViolation(
                        violation,
                      ),
                    ),
                  );
                },
              );
            })
          ],
        ),
      ),
      floatingActionButton: Obx(
        () {
          return FloatingActionButton.extended(
            onPressed:
                controller.isCreateLoading ? null : controller.addTrafficFine,
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
