import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gamaapp/app/auth/presenter/controllers/sign_in_controller.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_home_controller.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/images.dart';
import '../../../../shared/themes/palette.dart';
import '../../../../shared/widgets/square_line.dart';
import '../widgets/started_occurrence_card.dart';

class CopHomePage extends GetView<CopHomeController> {
  const CopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authController = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: Palette.primary,
        leading: IconButton(
          onPressed: authController.signOut,
          icon: const Icon(
            PhosphorIcons.sign_out,
            color: Palette.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Ink(
              color: Palette.primary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Image.asset(
                      Images.logoPNG,
                      height: 163,
                      width: 164,
                    ),
                  ),
                  const StartedOccurrenceCard(),
                  const SizedBox(height: 24),
                  const SquaresLines(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Selecione para qual módulo deseja prosseguir',
                    style: TextStyle(
                      color: Palette.black,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 1.80,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: controller.goToOcurrence,
                          child: Ink(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Palette.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  PhosphorIcons.police_car,
                                  size: 80,
                                  color: Palette.primary,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 8,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: Palette.red,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Ocorrências',
                                  style: TextStyle(
                                    color: Palette.primary,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: 1.40,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: controller.goToTrafficFine,
                          child: Ink(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Palette.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  PhosphorIcons.notepad,
                                  size: 80,
                                  color: Palette.primary,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 8,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: Palette.red,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Multas',
                                  style: TextStyle(
                                    color: Palette.primary,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: 1.40,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
