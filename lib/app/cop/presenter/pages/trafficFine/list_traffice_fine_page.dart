import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficFine/listed_traffic_fina_info.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
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
        title: const Text('Multas'),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchAllTrafficFines,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Busque pela placa',
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      controller: controller.createdSince,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: '_ _/_ _/_ _ _ _',
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      controller: controller.createdUntil,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: '_ _/_ _/_ _ _ _',
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.trafficFines.length,
                      itemBuilder: (context, index) {
                        ListedTrafficFineInfo listedItem =
                            controller.trafficFines[index];
                        return Container(
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
                        );
                      },
                    )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Nova multa'),
      ),
    );
  }
}
