import 'package:flutter/material.dart';
import 'package:gamaapp/app/login/presenter/pages/sign_in_page.dart';
import 'package:get/get.dart';

class Routes {
  static GetPage get login => GetPage(
        name: '/login',
        page: () => const SignInPage(),
      );

  static GetPage get testPageToNavigationOnSuccessLogin => GetPage(
        name: '/success',
        page: () => Scaffold(
          appBar: AppBar(
            title: const Text('deu bom'),
          ),
          body: const Text("Hey"),
        ),
      );
}
