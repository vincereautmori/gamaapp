import 'package:flutter/material.dart';
import 'package:gamaapp/app/login/presenter/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('SignInPage')),
        body: const SafeArea(child: Text('SignInController')));
  }
}
