import 'package:expensify_app/app/modules/authentication/views/authentication_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  // ignore: unused_field
  final box = GetStorage();
  String firstLetter = '';
  String emailid = "";
  String username = '';
  void _startingLetter() {
    firstLetter = box.read("email").toString();
    username = box.read('username').toString();
    emailid = firstLetter;
    firstLetter = firstLetter.substring(0, 1);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signoutmethod() async {
    await _auth.signOut();
    Get.offAll(() => AuthenticationView());
    await box.remove('email');
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _startingLetter();
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
