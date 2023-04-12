import 'package:flutter/material.dart';

import '../../../../shared/widgets/textfield.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GamaTextField(
      label: "Senha",
      isObscure: isObscure,
      placeholder: 'Insira sua senha',
      suffix: IconButton(
        onPressed: () => setState(() {
          isObscure = !isObscure;
        }),
        icon: Icon(
          isObscure
              ? Icons.visibility_off_outlined
              : Icons.remove_red_eye_outlined,
        ),
      ),
    );
  }
}
