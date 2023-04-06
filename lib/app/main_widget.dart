import 'package:flutter/material.dart';
import 'package:gamaapp/app/routes.dart';
import 'package:get/get.dart';

import '../shared/themes/themes.dart';

class GamaApp extends StatelessWidget {
  const GamaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: GamaThemes().lightTheme,
      initialRoute: '/login',
      getPages: [
        Routes.login,
      ],
    );
  }
}
