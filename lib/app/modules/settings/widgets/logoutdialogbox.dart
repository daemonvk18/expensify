import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutDialogBox extends StatelessWidget {
  const LogoutDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final SettingsController settingsController = Get.find();
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.height * 0.02,
            vertical: screenSize.height * 0.03),
        decoration: BoxDecoration(
            color: AppColors.lightthemeprimaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //are you sure you want to logout text
            Text(
              "Are you sure,you want to logout?",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.headingsgreycolor)),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //cancel button
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.fabcolor),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.02,
                        vertical: screenSize.height * 0.02),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightthemeprimaryColor)),
                    ),
                  ),
                ),
                //logout button
                GestureDetector(
                  onTap: () {
                    settingsController.signoutmethod();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.fabcolor),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.02,
                        vertical: screenSize.height * 0.02),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightthemeprimaryColor)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
