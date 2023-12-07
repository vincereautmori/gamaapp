import 'package:flutter/material.dart';
import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/images.dart';
import '../../../../shared/themes/palette.dart';
import '../../../../shared/widgets/buttons/button.dart';
import '../../../../shared/widgets/square_line.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/email_textfield.dart';
import '../widgets/password_textfield.dart';

class SignInPage extends GetView<AuthenticationController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text(
                        'Bem vindo à GAMA',
                        style: context.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Identifique-se para acessar ao aplicativo!',
                        style: context.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  EmailTextField(
                    onChange: controller.setEmail,
                  ),
                  const SizedBox(height: 8),
                  PasswordTextField(
                    onChange: controller.setPassword,
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => GamaButton(
                      text: 'Entrar',
                      onPressed: () async {
                        await controller.signIn();
                      },
                      isLoading: controller.isLoading,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Novo por aqui?",
                        style: Texts.subtitle.copyWith(color: Palette.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(RoutesNames.signup);
                          },
                          child: const Text("Cadastre-se"))
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
