import 'package:flutter/material.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:gamaapp/shared/widgets/textfield.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/palette.dart';
import '../../../../shared/themes/text_theme.dart';
import '../controllers/profile_controller.dart';

class UpdatePasswordPage extends GetView<ProfileController> {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar senha'),
        backgroundColor: Palette.primary,
        foregroundColor: Palette.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          Text(
            "Crie uma nova senha que não pode ser igual a anterior",
            style: Texts.cardTitle,
          ),
          const SizedBox(height: 16),
          GamaTextField(
            label: "Senha antiga",
            controller: controller.oldPassword,
            isObscure: true,
            placeholder: "Informe sua senha antiga",
          ),
          const SizedBox(height: 8),
          GamaTextField(
            label: "Nova antiga",
            controller: controller.newPassword,
            isObscure: true,
            placeholder: "Informe sua senha nova",
          ),
          const SizedBox(height: 24),
          Obx(() => GamaButton(
                text: "Alterar senha",
                onPressed: controller.handleUpdatePassword,
                isLoading: controller.isLoading,
              ))
        ],
      ),
    );
  }
}
