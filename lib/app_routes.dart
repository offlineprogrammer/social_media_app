import 'package:get/get.dart';

import 'controllers/bindings/homepage_bindings.dart';
import 'pages/email_sign_in_page.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/sign_in_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/home', page: () => HomePage(), binding: HomeBindings()),
    GetPage(
      name: '/emaillogin',
      page: () => EmailSignInPage(),
    ),
    GetPage(
      name: '/signin',
      page: () => SignInPage(),
    ),
    GetPage(
      name: '/settings',
      page: () => SettingsPage(),
      binding: HomeBindings(),
    ),
  ];
}
