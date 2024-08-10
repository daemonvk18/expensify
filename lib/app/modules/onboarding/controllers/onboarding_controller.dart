import 'package:expensify_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:expensify_app/app/modules/authentication/views/authentication_view.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  Future<void> _navigatetoSecondOnboardingScreen() async {
    Future.delayed(Duration(seconds: 4), () {
      //check if some is already logged or registered in ,if they are directly go to the home
      Get.offAll(() => AuthenticationView());
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
