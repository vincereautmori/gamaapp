import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_home_controller.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/images.dart';
import '../../../../shared/themes/palette.dart';
import '../../../../shared/widgets/square_line.dart';

class CopHomePage extends GetView<CopHomeController> {
  const CopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Ink(
              color: Palette.primary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 64, bottom: 24),
                    child: Image.asset(
                      Images.logoPNG,
                      height: 163,
                      width: 164,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 30),
                    child: const Text(
                        "Nenhuma ocorrência em atendimento no momento"),
                  ),
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
