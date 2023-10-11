import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/palette.dart';
import '../../../../shared/widgets/square_line.dart';

class FilterHeader extends GetView<CopTrafficFineController> {
  const FilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.primary,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: controller.licensePlateFilter,
              onChanged: controller.debounceSearchByLicensePlate,
              inputFormatters: [PlacaVeiculoInputFormatter()],
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Busque pela placa',
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    controller: controller.createdSince,
                    readOnly: true,
                    onTap: () async {
                      DateTime? datePicked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (datePicked != null) {
                        controller.createdSince.text =
                            datePicked.formatDate('dd/MM/yyyy') ?? "";
                      }
                    },
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
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    controller: controller.createdUntil,
                    readOnly: true,
                    onTap: () async {
                      DateTime? datePicked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (datePicked != null) {
                        controller.createdUntil.text =
                            datePicked.formatDate('dd/MM/yyyy') ?? "";
                      }
                    },
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
          ),
          const SizedBox(height: 24),
          const SquaresLines(),
        ],
      ),
    );
  }
}
