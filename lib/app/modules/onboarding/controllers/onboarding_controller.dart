import 'package:expensify_app/app/modules/authentication/views/authentication_view.dart';
import 'package:expensify_app/app/modules/navbar/views/navbar_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final box = GetStorage();

  Future<void> _navigatetoSecondOnboardingScreen() async {
    Future.delayed(Duration(seconds: 4), () {
      //verify if some has logged in before
      if (box.read('email') != null) {
        Get.offAll(() => NavbarView());
      } else {
        Get.offAll(() => AuthenticationView());
      }
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _navigatetoSecondOnboardingScreen();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
