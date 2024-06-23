import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController

  Future<void> _navigatetoSecondOnboardingScreen() async {
    Future.delayed(Duration(seconds: 4), () {
      //Get.to(()=>);
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
