import 'package:expensify_app/app/modules/authentication/views/authentication_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signoutmethod() async {
    try {
      // Attempt to sign out from Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out from Firebase
      await _auth.signOut();

      // Remove stored email
      await box.remove('email');

      // Navigate to the Authentication View
      Get.offAll(() => AuthenticationView());

      print('Sign out successful');
    } catch (e) {
      print('Failed to sign out: $e');
      // Optionally, show a message to the user
      Get.snackbar(
        'Error',
        'Failed to sign out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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
