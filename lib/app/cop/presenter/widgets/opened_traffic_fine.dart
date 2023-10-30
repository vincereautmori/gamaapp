import 'package:flutter/material.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/app/cop/presenter/widgets/fine_image.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/themes/palette.dart';
import '../../../../shared/themes/text_theme.dart';
import '../../domain/entities/trafficFine/traffic_fine_info.dart';

class OpenedTrafficFine extends GetView<CopTrafficFineController> {
  const OpenedTrafficFine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      TrafficFineInfo? trafficFine = controller.trafficFine;
      if (controller.isFetchLoaging || trafficFine == null) {
        return const Dialog(
          child: SizedBox(
            height: 64,
            width: 64,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      return AlertDialog(
        title: Text(trafficFine.licensePlate),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Situação:"),
            trafficFine.active
                ? const Row(
                    children: [Text("Ativa"), Icon(Icons.check)],
                  )
                : const Row(
                    children: [Text("Inativa"), Icon(Icons.close)],
                  ),
            Text(
              trafficFine.createdAt.formatDate('dd/MM/yyyy - HH:mm')!,
              style: Texts.body.copyWith(
                color: Palette.grey,
              ),
            ),
            FineImage(imageUrl: trafficFine.imageUrl),
            const Text("Integração:"),
            Container(
              decoration: BoxDecoration(
                color: trafficFine.computed ? Colors.green : Palette.red,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                trafficFine.computed ? "Computado" : "Não computado",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Palette.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
