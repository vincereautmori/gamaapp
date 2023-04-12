import 'package:flutter/material.dart';

import '../../../../shared/widgets/textfield.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const GamaTextField(
      label: "E-mail",
      keyboardType: TextInputType.emailAddress,
      placeholder: 'Ex: email@gmail.com',
    );
  }
}
