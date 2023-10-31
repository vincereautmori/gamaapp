import 'package:flutter/material.dart';
import 'package:gamaapp/app/citizen/presenter/binds/home_bind.dart';
import 'package:gamaapp/app/citizen/presenter/pages/home_page.dart';
import 'package:gamaapp/app/citizen/presenter/pages/new_ocurrence_page.dart';
import 'package:gamaapp/app/cop/presenter/bindings/cop_home_binding.dart';
import 'package:gamaapp/app/cop/presenter/bindings/cop_traffic_fine_binding.dart';
import 'package:gamaapp/app/cop/presenter/pages/cop_home_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/trafficFine/new_traffic_fine_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/trafficFine/view_traffic_fine_page.dart';
import 'package:gamaapp/app/locations/presenter/bindings/location_binding.dart';
import 'package:gamaapp/app/main_bind.dart';
import 'package:get/get.dart';

import '../auth/presenter/pages/sign_in_page.dart';
import '../auth/presenter/pages/splashscreen_page.dart';
import '../citizen/presenter/controllers/new_ocurrence_controller.dart';
import '../cop/presenter/bindings/cop_traffic_violation_binding.dart';
import '../cop/presenter/pages/trafficFine/list_traffice_fine_page.dart';
import 'routes_name.dart';

class Routes {
  static GetPage get login => GetPage(
        name: RoutesNames.login,
        page: () => const SignInPage(),
      );

  static GetPage get splash => GetPage(
        name: RoutesNames.splash,
        page: () => const SplashScreen(),
        binding: MainBind(),
      );

  static GetPage get citizen => GetPage(
        name: RoutesNames.citizen,
        page: () => const HomePage(),
        binding: HomeBinding(),
      );

  static GetPage get newOcurrence => GetPage(
        name: RoutesNames.newOcurrence,
        page: () => const NewOcurrencePage<OcurrenceController>(),
      );

  static GetPage get cop => GetPage(
      name: RoutesNames.cop,
      bindings: [
        CopHomeBinding(),
        CopTrafficFineBinding(),
        CopTrafficViolationBinding(),
        LocationBinding(),
      ],
      page: () => const CopHomePage(),
      children: [
        GetPage(
          name: RoutesNames.ocurrence,
          page: () => const Center(
            child: Text(''),
          ),
        ),
        GetPage(
          name: RoutesNames.trafficFine,
          page: () => const TrafficFineList(),
        ),
      ]);

  static GetPage get viewTrafficFine => GetPage(
        name: RoutesNames.viewTrafficFine,
        page: () => const ViewTrafficFinePage(),
      );

  static GetPage get newTrafficFine => GetPage(
        name: RoutesNames.createTrafficFine,
        page: () => const NewTrafficFinePage(),
      );
}
