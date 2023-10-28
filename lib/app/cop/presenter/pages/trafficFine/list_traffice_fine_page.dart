import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/listed_traffic_fine_info.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/app/cop/presenter/widgets/filter_header.dart';
import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:gamaapp/shared/themes/images.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TrafficFineList extends GetView<CopTrafficFineController> {
  const TrafficFineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Multas',
        ),
        foregroundColor: Palette.white,
        backgroundColor: Palette.primary,
      ),
      body: RefreshIndicator(
        onRefresh: controller.search,
        child: Column(
          children: [
            const FilterHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  if (controller.isFetchLoading &&
                      controller.trafficFines.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.trafficFines.isEmpty) {
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
                            'Nenhuma multa no periodo',
                            style: Texts.subtitle,
                          )
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scroll,
                    itemCount: controller.trafficFines.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ListedTrafficFineInfo listedItem =
                          controller.trafficFines[index];
                      return InkWell(
                        onTap: () => Get.dialog(AlertDialog(
                          title: Text(listedItem.licensePlate),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                listedItem.createdAt
                                    .formatDate('dd/MM/yyyy - hh:mm')!,
                                style: Texts.body.copyWith(
                                  color: Palette.grey,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: listedItem.computed
                                      ? Colors.green
                                      : Palette.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  listedItem.computed
                                      ? "Computado"
                                      : "Não computado",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Palette.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listedItem.licensePlate.toUpperCase(),
                                    style: Texts.cardTitle,
                                  ),
                                  Text(
                                    listedItem.createdAt
                                        .formatDate('dd/MM/yyyy - hh:mm')!,
                                    style: Texts.body.copyWith(
                                      color: Palette.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: listedItem.computed
                                      ? Colors.green
                                      : Palette.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  listedItem.computed
                                      ? "Computado"
                                      : "Não computado",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Palette.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            Obx(() {
              if (controller.isFetchLoading &&
                  controller.trafficFines.isNotEmpty) {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(RoutesNames.createTrafficFine);
        },
        icon: const Icon(Icons.add),
        label: const Text('Nova multa'),
      ),
    );
  }
}
