import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/palette.dart';
import '../controllers/cop_traffic_violation_controller.dart';

class ViolationsBottomSheet extends GetView<CopTrafficViolationController> {
  const ViolationsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      showDragHandle: true,
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Marque as infração"),
                Obx(
                  () {
                    bool selected = controller.allViolationsChecked ||
                        controller.selectedTrafficViolations.length ==
                            controller.trafficViolations.length;
                    return ChoiceChip(
                      label:
                          Text(selected ? "Desmarcar todos" : "Marcar todos"),
                      selected: selected,
                      onSelected: (value) => controller.handleCheckAll(),
                      labelStyle: TextStyle(
                        color: selected ? Palette.white : Palette.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: Palette.grey.withOpacity(.5)),
          ),
          Obx(() {
            if (controller.isLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 16,
              children: List.from(
                controller.trafficViolations.map(
                  (violation) {
                    bool selected = controller.selectedTrafficViolations
                        .contains(violation);
                    return ChoiceChip(
                      label: Text(violation.name),
                      selected: selected,
                      onSelected: (value) {
                        if (!value) {
                          controller.unselectViolation(violation);
                        } else {
                          controller.selectViolation(violation);
                        }
                      },
                      labelStyle: TextStyle(
                        color: selected ? Palette.white : Palette.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}

  // ListView.builder(
  //           itemCount: controller.trafficViolations.length,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             TrafficViolationInfo violation =
  //                 controller.trafficViolations[index];
  //             return ListTile(
  //               leading: Text(violation.code),
  //               title: Text(violation.name),
  //               onTap: () {
  //                 controller.selectViolation(violation);
  //                 Get.back();
  //               },
  //             );
  //           },
  //         ),