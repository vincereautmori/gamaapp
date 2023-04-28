import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/themes/images.dart';
import '../../../../../shared/themes/palette.dart';
import '../../../../../shared/widgets/button.dart';
import '../../../../../shared/widgets/square_line.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/email_textfield.dart';
import '../widgets/password_textfield.dart';

class SignInPage extends GetView<SignInController> {
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
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Text(
                        'Bem vindo a GAMA',
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
                  const SizedBox(height: 10),
                  PasswordTextField(
                    onChange: controller.setPassword,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Esqueceu sua senha?",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Palette.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => GamaButton(
                        text: 'Entrar',
                        onPressed: () async {
                          await controller.signIn();
                        },
                        isLoading: controller.isLoading,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
