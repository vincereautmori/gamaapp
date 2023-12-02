import 'package:flutter/material.dart';
import 'package:gamaapp/app/ocurrences/presenter/controllers/ocurrences_controller.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/palette.dart';

class StartedOccurrenceCard extends GetView<OccurrencesController> {
  const StartedOccurrenceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.startedOccurrence != null) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.circular(6),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Text(
                  "Ocorrência ${controller.startedOccurrence!.id} está ativa no momento"),
            ),
            const LinearProgressIndicator()
          ],
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: const Text("Nenhuma ocorrência em atendimento no momento"),
      );
    });
  }
}
