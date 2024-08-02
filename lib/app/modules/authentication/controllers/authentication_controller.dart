import 'package:expensify_app/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  //TODO: Implement AuthenticationController

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
  Rxn<User> _user = Rxn<User>();
  final box = GetStorage();

  //getter method
  User? get user => _user.value;

  //login method
  Future<void> loginMethod(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', "Login Successful");
      Get.to(() => HomeView());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //register method
  Future<void> registerMethod(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success", "Account Created Successfully");
      //go to home page
      Get.to(() => HomeView());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signoutmethod() async {
    await _auth.signOut();
  }

  // ignore: unused_element
  void _handleAuthChanged(User? user) {
    if (user == null) {
      box.write('isLoggedIn', false);
    } else {
      box.write('isLoggedIn', true);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    //intalizing the user
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _handleAuthChanged);
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
