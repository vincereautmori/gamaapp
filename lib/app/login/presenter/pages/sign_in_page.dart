import 'package:flutter/material.dart';
import 'package:gamaapp/app/login/presenter/controllers/sign_in_controller.dart';
import 'package:gamaapp/app/login/presenter/widgets/square_line.dart';
import 'package:gamaapp/shared/themes/images.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/widgets/button.dart';
import 'package:get/get.dart';

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
                height: 139,
                width: 139,
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Ex: email@gmail.com",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Palette.lightGrey,
                      ),
                    ),
                    filled: true,
                    fillColor: Palette.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Insira sua senha",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Palette.lightGrey,
                      ),
                    ),
                    filled: true,
                    fillColor: Palette.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Esqueceu sua senha?",
                  textAlign: TextAlign.right,
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
