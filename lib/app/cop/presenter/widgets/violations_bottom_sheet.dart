import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/palette.dart';
import '../../domain/entities/trafficViolations/traffic_violation_info.dart';
import '../controllers/cop_traffic_violation_controller.dart';

class ListViolationsDialog extends GetView<CopTrafficViolationController> {
  const ListViolationsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Infrações"),
          IconButton(
            icon: const Icon(PhosphorIcons.x),
            onPressed: Get.back,
          )
        ],
      ),
      content: Obx(
        () => SizedBox(
          height: 500,
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selecione as infrações abaixo",
                style: Texts.subtitle,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.trafficViolations.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      TrafficViolationInfo violation =
                          controller.trafficViolations[index];

                      bool selected = controller.selectedTrafficViolations
                          .contains(violation);

                      return ListTile(
                        leading:
                            selected ? const Icon(PhosphorIcons.check) : null,
                        title: Text('Cód. ${violation.code}'),
                        subtitle: Text(violation.name),
                        selected: selected,
                        onTap: () {
                          if (selected) {
                            controller.unselectViolation(violation);
                          } else {
                            controller.selectViolation(violation);
                          }
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GamaButton(
          text: "Limpar filtros",
          onPressed: controller.selectedTrafficViolations.clear,
          backgroundColor: Palette.red,
        ),
        GamaButton(text: "OK", onPressed: Get.back),
      ],
    );
  }
}
