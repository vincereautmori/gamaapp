import 'package:flutter/material.dart';
import 'package:gamaapp/app/auth/presenter/controllers/sign_in_controller.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_home_controller.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/images.dart';
import '../../../../shared/themes/palette.dart';
import '../../../../shared/widgets/buttons/outlined_button.dart';
import '../../../../shared/widgets/square_line.dart';

class CopHomePage extends GetView<CopHomeController> {
  const CopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController signInController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Palette.primary,
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Image.asset(
                  Images.logoPNG,
                  height: 138,
                  width: 138,
                ),
              ),
            ),
            const SquaresLines(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    Images.copIllustration,
                    height: 212,
                    width: 240,
                  ),
                  const SizedBox(height: 32),
                  GamaButton(
                    text: 'Cadastro de Multas',
                    onPressed: controller.goToOcurrence,
                    isLoading: false,
                  ),
                  const SizedBox(height: 16),
                  GamaButton(
                    text: 'Cadastro de Denúncias',
                    onPressed: controller.goToOcurrence,
                    isLoading: false,
                  ),
                  const SizedBox(height: 64),
                  GamaOutlinedButton(
                    text: 'Sair',
                    onPressed: () => signInController.signOut(),
                    isLoading: false,
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
