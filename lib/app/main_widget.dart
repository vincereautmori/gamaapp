import 'package:flutter/material.dart';
import 'package:gamaapp/app/camera/presenter/binds/camera_bind.dart';
import 'package:gamaapp/app/routes/routes.dart';
import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:get/get.dart';

import '../shared/themes/themes.dart';

class GamaApp extends StatelessWidget {
  const GamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: GamaThemes().lightTheme,
      initialBinding: CameraBind(),
      initialRoute: RoutesNames.splash,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
