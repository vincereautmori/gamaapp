import 'package:gamaapp/app/citizen/presenter/binds/home_bind.dart';
import 'package:gamaapp/app/cop/presenter/bindings/cop_home_binding.dart';
import 'package:gamaapp/app/cop/presenter/bindings/cop_traffic_fine_binding.dart';
import 'package:gamaapp/app/cop/presenter/pages/cop_home_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/map_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/trafficFine/new_traffic_fine_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/trafficFine/view_traffic_fine_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/view_ocurrence_page.dart';
import 'package:gamaapp/app/locations/presenter/bindings/location_binding.dart';
import 'package:gamaapp/app/main_bind.dart';
import 'package:gamaapp/app/ocurrences/presenter/binds/occurrence_binding.dart';
import 'package:gamaapp/app/ocurrences/presenter/binds/occurrence_properties_binding.dart';
import 'package:gamaapp/app/profile/presenter/bindings/profile_binding.dart';
import 'package:gamaapp/app/profile/presenter/pages/update_password_page.dart';
import 'package:gamaapp/shared/apagar_depois/warning_page.dart';
import 'package:get/get.dart';

import '../auth/presenter/pages/sign_in_page.dart';
import '../auth/presenter/pages/splashscreen_page.dart';
import '../cop/presenter/bindings/cop_traffic_violation_binding.dart';
import '../cop/presenter/pages/trafficFine/list_traffic_fine_page.dart';
import '../ocurrences/presenter/pages/list_occurrences_page.dart';
import '../ocurrences/presenter/pages/new_occurrence_page.dart';
import '../profile/presenter/pages/profile_page.dart';
import '../signup/presenter/pages/signup_page.dart';
import 'routes_name.dart';

class Routes {
  static GetPage get login => GetPage(
        name: RoutesNames.login,
        page: () => const SignInPage(),
      );

  static GetPage get splash => GetPage(
        name: RoutesNames.splash,
        page: () => const SplashScreen(),
        bindings: [ProfileBinding(), MainBind()],
      );

  static GetPage get citizen => GetPage(
        name: RoutesNames.citizen,
        page: () => const OccurrencesList(),
        bindings: [
          OccurrenceBinding(),
          OccurrencePropertiesBinding(),
          HomeBinding(),
          LocationBinding(),
        ],
      );

  static GetPage get viewOccurrence => GetPage(
        name: RoutesNames.viewOccurrence,
        page: () => const ViewOcurrencePage(),
      );

  static GetPage get newOccurrence => GetPage(
        name: RoutesNames.newOccurrence,
        page: () => const NewOccurrencePage(),
      );

  static GetPage get cop => GetPage(
      name: RoutesNames.cop,
      bindings: [
        OccurrenceBinding(),
        OccurrencePropertiesBinding(),
        CopHomeBinding(),
        CopTrafficFineBinding(),
        CopTrafficViolationBinding(),
        LocationBinding(),
      ],
      page: () => const CopHomePage(),
      children: [
        GetPage(
          name: RoutesNames.occurrence,
          page: () => const MapPage(),
        ),
        GetPage(
          name: RoutesNames.trafficFine,
          page: () => const TrafficFineList(),
        ),
      ]);

  static GetPage get warningPage => GetPage(
        name: '/warning',
        page: () => const WarningPage(),
      );

  static GetPage get viewTrafficFine => GetPage(
        name: RoutesNames.viewTrafficFine,
        page: () => const ViewTrafficFinePage(),
      );

  static GetPage get newTrafficFine => GetPage(
        name: RoutesNames.createTrafficFine,
        page: () => const NewTrafficFinePage(),
      );

  static GetPage get signUp => GetPage(
        name: RoutesNames.signup,
        page: () => const SignupPage(),
      );

  static GetPage get profile => GetPage(
        name: RoutesNames.profile,
        page: () => const ProfilePage(),
      );

  static GetPage get updatePassword => GetPage(
        name: RoutesNames.updatePassword,
        page: () => const UpdatePasswordPage(),
      );

  static List<GetPage> get pages => [
        Routes.login,
        Routes.splash,
        Routes.cop,
        Routes.citizen,
        Routes.newTrafficFine,
        Routes.viewTrafficFine,
        Routes.warningPage,
        Routes.viewOccurrence,
        Routes.newOccurrence,
        Routes.signUp,
        Routes.profile,
        Routes.updatePassword
      ];
}
