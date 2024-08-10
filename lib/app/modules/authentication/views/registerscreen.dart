import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController =
        Get.put(AuthenticationController());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          //leave some space
          SizedBox(height: screenSize.height * 0.1),
          //logo and text
          SizedBox(
              height: screenSize.height * 0.09,
              width: screenSize.height * 0.09,
              child: SvgPicture.asset("assets/images/expensify_logo.svg")),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          //logo text
          Text(
            "Expensify",
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: 24,
                    color: AppColors.logocolor,
                    fontWeight: FontWeight.w800)),
          ),
          SizedBox(
            height: screenSize.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              cursorColor: AppColors.logocolor,
              controller: authenticationController.emailtext_register,
              decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/images/icon.png"),
                  hintText: 'Email',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.logocolor),
                      borderRadius: BorderRadius.circular(30)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.logocolor),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.logocolor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.logocolor),
                      borderRadius: BorderRadius.circular(30)),
                  filled: true),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                cursorColor: AppColors.logocolor,
                controller: authenticationController.passwordtext_register,
                obscureText: !authenticationController.ispasswordvisible.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.logocolor),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(authenticationController.ispasswordvisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: authenticationController
                        .togglepasswordvisibilty_register,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                cursorColor: AppColors.logocolor,
                controller: authenticationController.confirmpassword,
                obscureText:
                    !authenticationController.isConfirmPasswordVisible.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.logocolor),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        authenticationController.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                    onPressed: authenticationController
                        .toggleConfirmPasswordVisibility,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          //sign up option
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle login action
                  authenticationController.registerMethod(
                      authenticationController.emailtext_register.text,
                      authenticationController.passwordtext_register.text,
                      authenticationController.confirmpassword.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.logobluecolor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text('SIGN UP'),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.04,
          ),
          //move to loghin page if having account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.logocolor)),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text('Login here',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.logobluecolor))),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
