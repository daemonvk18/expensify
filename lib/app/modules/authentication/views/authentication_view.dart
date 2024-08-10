import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/authentication/views/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthenticationController controller =
        Get.put(AuthenticationController());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            //username and password columns
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                cursorColor: AppColors.logocolor,
                controller: controller.usernametext,
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
            //password field
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: AppColors.logocolor,
                  controller: controller.passwordtext,
                  obscureText: !controller.isPasswordVisible.value,
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
                      icon: Icon(controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            //login button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login action
                    controller.loginMethod(controller.usernametext.text,
                        controller.passwordtext.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.logobluecolor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text('LOGIN'),
                ),
              ),
            ),
            //forgrt password
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            TextButton(
              onPressed: () {
                // Handle forgot password action
              },
              child: Text(
                'FORGOT PASSWORD',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.forgetPasswordColor)),
              ),
            ),
            //or option
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Text(
              "Or",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.forgetPasswordColor)),
            ),
            //google login option
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle Google login action
                    controller.googleSigninMethod();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                          color: AppColors.googleboxborder, width: 1),
                    ),
                  ),
                  icon: SvgPicture.asset("assets/images/googlelogo.svg"),
                  label: Text(
                    'CONTINUE WITH GOOGLE',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.googletext)),
                  ),
                ),
              ),
            ),
            //account register option
            SizedBox(
              height: screenSize.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.logocolor)),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => RegisterPage());
                  },
                  child: Text('Register here',
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
      ),
    );
  }
}
