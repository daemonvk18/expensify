import 'package:expensify_app/app/modules/authentication/views/authentication_view.dart';
import 'package:expensify_app/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  var isPasswordVisible = false.obs;
  var ispasswordvisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  //username textcontroller
  var usernametext = TextEditingController();
  var emailtext_register = TextEditingController();
  //password textcontroller
  var passwordtext = TextEditingController();
  var passwordtext_register = TextEditingController();
  var confirmpassword = TextEditingController();
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglepasswordvisibilty_register() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  final box = GetStorage();

  //getter method
  User? get user => _user.value;

  //login method
  Future<void> loginMethod(String email, String password) async {
    if (!checkEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter the valid email id");
      return;
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', "Login Successful");
      await box.write('email', email);
      Get.offAll(() => HomeView());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //register method
  Future<void> registerMethod(
      String email, String password, String confirmpassword) async {
    //check whether the password and confirm password matches
    if (!checkEmail(email)) {
      Get.snackbar('Invalid Email', "Please enter the valid email id");
      return;
    }
    if (passwordtext != confirmpassword) {
      Get.snackbar(
          "Password mismatch", "Password and Confirm Password donot match");
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success", "Account Created Successfully");
      //oncd the login is sucessful store that using get storage
      await box.write('email', email);
      //go to home page
      Get.offAll(() => HomeView());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //google sign in method
  Future<void> googleSigninMethod() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        await _auth.signInWithCredential(authCredential);
        await box.write('email', googleUser.email);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signoutmethod() async {
    await _auth.signOut();
    await box.remove('email');
  }

  // ignore: unused_element
  void _handleAuthChanged(User? user) {
    if (user == null) {
      box.write('isLoggedIn', false);
    } else {
      box.write('isLoggedIn', true);
    }
  }

  //check whether the entered email is valid
  bool checkEmail(String email) {
    final RegExp emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailExp.hasMatch(email);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // //intalizing the user
    // _user.bindStream(_auth.authStateChanges());
    // ever(_user, _handleAuthChanged);
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => AuthenticationView());
    } else {
      Get.offAll(() => HomeView());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
