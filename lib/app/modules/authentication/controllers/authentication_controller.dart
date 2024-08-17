import 'package:expensify_app/app/modules/authentication/views/authentication_view.dart';
import 'package:expensify_app/app/modules/navbar/views/navbar_view.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
      Get.offAll(() => NavbarView());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //register method
  Future<void> registerMethod(String email, String username, String password,
      String confirmpassword) async {
    //check whether the password and confirm password matches
    if (!checkEmail(email)) {
      Get.snackbar('Invalid Email', "Please enter the valid email id");
      return;
    }
    if (password != confirmpassword) {
      Get.snackbar(
          "Password mismatch", "Password and Confirm Password donot match");
      return;
    }
    if (!checkUsername(username)) {
      Get.snackbar('Username',
          "The username cannot contain characters except alphabets,numbers,_ and spaces");
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success", "Account Created Successfully");
      //oncd the login is sucessful store that using get storage
      await box.write('email', email);
      //store the username
      await box.write('username', username);
      //go to home page
      Get.offAll(() => NavbarView());
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
        Get.offAll(() => NavbarView());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    }
  }

  void signoutmethod() async {
    try {
      //first signout from google
      await _googleSignIn.signOut();
      //then singout from firebase
      await _auth.signOut();
      //delete the email from box storage
      await box.remove('email');
      Get.offAll(() => AuthenticationView());
    } catch (e) {
      print(e);
    }
  }

  // ignore: unused_element
  // void _handleAuthChanged(User? user) {
  //   if (user == null) {
  //     box.write('isLoggedIn', false);
  //   } else {
  //     box.write('isLoggedIn', true);
  //   }
  // }

  //check whether the entered email is valid
  bool checkEmail(String email) {
    final RegExp emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailExp.hasMatch(email);
  }

  bool checkUsername(String username) {
    final RegExp usernamexp = RegExp(r'^[a-zA-Z0-9_ ]+$');
    return usernamexp.hasMatch(username);
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
    // _user = Rx<User?>(_auth.currentUser);
    // _user.bindStream(_auth.authStateChanges());
    // ever(_user, _initialScreen);
  }

  // _initialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => AuthenticationView());
  //   } else {
  //     Get.offAll(() => NavbarView());
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
