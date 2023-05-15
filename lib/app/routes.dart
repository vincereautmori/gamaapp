import 'package:flutter/material.dart';
import 'package:gamaapp/app/cop/presenter/bindings/cop_home_binding.dart';
import 'package:gamaapp/app/cop/presenter/pages/cop_home_page.dart';
import 'package:get/get.dart';

import 'auth/presenter/pages/sign_in_page.dart';
import 'auth/presenter/pages/splashscreen_page.dart';

class Routes {
  static GetPage get login => GetPage(
        name: '/login',
        page: () => const SignInPage(),
      );

  static GetPage get splash =>
      GetPage(name: '/splash', page: () => const SplashScreen());

  static GetPage get citizen => GetPage(
        name: '/citizen',
        page: () => Scaffold(
          appBar: AppBar(
            title: const Text('Cidadão'),
          ),
          body: const Text("Hey"),
        ),
      );

  static GetPage get cop => GetPage(
          name: '/cop',
          binding: CopHomeBinding(),
          page: () => const CopHomePage(),
          children: [
            GetPage(
                name: '/ocurrence',
                page: () => const Center(
                      child: Text(''),
                    ))
          ]);
}
