import 'package:flutter/material.dart';

import '../../../../shared/widgets/textfield.dart';

class EmailTextField extends StatelessWidget {
  final void Function(String)? onChange;

  const EmailTextField({super.key, this.onChange});

  @override
  Widget build(BuildContext context) {
    return GamaTextField(
      label: "Usuário",
      keyboardType: TextInputType.emailAddress,
      placeholder: 'Insira seu e-mail ou usuário',
      onChange: onChange,
    );
  }
}
