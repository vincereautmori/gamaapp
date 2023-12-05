import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamaapp/app/signup/presenter/controllers/signup_controller.dart';
import 'package:gamaapp/app/signup/presenter/states/signup_states.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:gamaapp/shared/widgets/textfield.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/images.dart';
import '../../../../shared/themes/palette.dart';
import '../../../../shared/themes/text_theme.dart';
import '../../../../shared/widgets/square_line.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        foregroundColor: Palette.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Palette.primary,
              padding: const EdgeInsets.only(bottom: 48),
              child: Center(
                child: Image.asset(
                  Images.logoPNG,
                  height: 138,
                  width: 138,
                ),
              ),
            ),
            const SquaresLines(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                  key: controller.signUpKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Cadastre-se',
                        style: Texts.title,
                      ),
                      const SizedBox(height: 16),
                      GamaTextField(
                        label: "CPF",
                        placeholder: "Informe seu documento",
                        controller: SignupStates.documentNumberInput.value,
                        keyboardType: TextInputType.number,
                        masks: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GamaTextField(
                        label: "Primeiro Nome",
                        placeholder: "Informe seu primeiro nome",
                        controller: SignupStates.firstNameInput.value,
                      ),
                      const SizedBox(height: 8),
                      GamaTextField(
                        label: "Último Nome",
                        placeholder: "Informe seu último nome",
                        controller: SignupStates.lastNameInput.value,
                      ),
                      const SizedBox(height: 8),
                      GamaTextField(
                        label: "E-mail",
                        placeholder: "E-mail para acessar o sistema",
                        controller: SignupStates.emailInput.value,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      GamaTextField(
                        label: "Usuário",
                        placeholder: "Usuário para acessar o sistema",
                        controller: SignupStates.usernameInput.value,
                      ),
                      const SizedBox(height: 8),
                      GamaTextField(
                        label: "Senha",
                        placeholder: "Crie uma senha",
                        controller: SignupStates.passwordInput.value,
                        isObscure: true,
                      ),
                      const SizedBox(height: 24),
                      Obx(() => GamaButton(
                            text: "Criar usuário",
                            onPressed: controller.signUp,
                            isLoading: controller.isLoading,
                          )),
                      const SizedBox(height: 24),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
