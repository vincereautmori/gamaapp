import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'auth/login/presenter/pages/sign_in_page.dart';
import 'auth/splashscreen/presenter/pages/splashscreen_page.dart';

class Routes {
  static GetPage get login => GetPage(
        name: '/login',
        page: () => const SignInPage(),
      );

  static GetPage get splash =>
      GetPage(name: '/splash', page: () => const SplashScreen());

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
