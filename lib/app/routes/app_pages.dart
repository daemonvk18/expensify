import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
