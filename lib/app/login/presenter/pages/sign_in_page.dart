import 'package:flutter/material.dart';
import 'package:gamaapp/app/login/presenter/controllers/sign_in_controller.dart';
import 'package:gamaapp/app/login/presenter/widgets/password_textfield.dart';
import 'package:gamaapp/app/login/presenter/widgets/square_line.dart';
import 'package:gamaapp/shared/themes/images.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/email_textfield.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                const EmailTextField(),
                const SizedBox(height: 10),
                const PasswordTextField(),
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
                GamaButton(
                  text: 'Entrar',
                  onPressed: () {},
                  isLoading: false,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
