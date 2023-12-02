import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamaapp/shared/themes/images.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/ocurrences/listed_occurrences_info.dart';
import '../controllers/occurrences_properties_controller.dart';
import '../controllers/ocurrences_controller.dart';
import '../widgets/filter_header.dart';

class OccurrencesList extends GetView<OccurrencesController> {
  const OccurrencesList({super.key});

  @override
  Widget build(BuildContext context) {
    final OccurrencesPropertiesController propertiesController =
        Get.find<OccurrencesPropertiesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ocorrências',
        ),
        foregroundColor: Palette.white,
        backgroundColor: Palette.primary,
      ),
      body: RefreshIndicator(
        onRefresh: controller.search,
        child: Column(
          children: [
            const FilterHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  if (controller.isOccurrencesLoading &&
                      controller.occurrences.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.occurrences.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: SvgPicture.asset(Images.emptyState),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhuma ocurrência no periodo',
                            style: Texts.subtitle,
                          )
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scroll,
                    itemCount: controller.occurrences.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ListedOccurrencesInfo listedItem =
                          controller.occurrences[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () async {
                          controller.viewOccurrence(listedItem.id);
                        },
                        title: Text(
                          listedItem.name.toUpperCase(),
                          style: Texts.cardTitle,
                          overflow: TextOverflow.fade,
                        ),
                        subtitle: Text(
                          listedItem.occurrenceType,
                          style: Texts.body.copyWith(
                            color: Palette.grey,
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: listedItem.occurrenceUrgencyLevel == "Baixa"
                                ? Colors.grey
                                : listedItem.occurrenceUrgencyLevel == "Média"
                                    ? Palette.warning
                                    : Palette.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            listedItem.occurrenceUrgencyLevel,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Palette.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            Obx(() {
              if (controller.isOccurrencesLoading &&
                  controller.occurrences.isNotEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return const SizedBox();
            }),
          ],
        ),
      ),
      floatingActionButton: Obx(() => controller.hideAddButton
          ? const SizedBox()
          : FloatingActionButton.extended(
              onPressed: propertiesController.fetchProperties,
              icon: const Icon(Icons.add),
              label: const Text('Nova ocurrência'),
            )),
    );
  }
}
