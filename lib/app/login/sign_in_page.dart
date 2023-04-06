import 'package:flutter/material.dart';
import 'package:gamaapp/shared/widgets/button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GamaButton(text: 'Entrar', onPressed: () {}, isLoading: false),
      ),
    );
  }
}
