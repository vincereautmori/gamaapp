import 'package:gamaapp/app/login/presenter/pages/sign_in_page.dart';
import 'package:get/get.dart';

class Routes {
  static GetPage get login => GetPage(
        name: '/login',
        page: () => const SignInPage(),
      );
}
