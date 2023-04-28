import 'package:flutter/material.dart';
import 'package:gamaapp/app/routes.dart';
import 'package:get/get.dart';

import '../shared/themes/themes.dart';
import 'main_bind.dart';

class GamaApp extends StatelessWidget {
  const GamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: GamaThemes().lightTheme,
      initialBinding: MainBind(),
      initialRoute: '/splash',
      getPages: [
        Routes.login,
        Routes.splash,
        Routes.testPageToNavigationOnSuccessLogin,
      ],
    );
  }
}
