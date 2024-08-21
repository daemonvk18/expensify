import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/settings/widgets/logoutdialogbox.dart';
import 'package:expensify_app/app/modules/settings/widgets/settingsoptioncards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final SettingsController controller = Get.put(SettingsController());
    return Scaffold(
      //seetings text
      body: Column(
        children: [
          //settings text
          Container(
            height: screenSize.height * 0.22,
            width: screenSize.width,
            decoration: BoxDecoration(color: AppColors.lightgreycolor),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Text(
                    "Settings",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.headingsgreycolor)),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  //account photo and details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //account photo
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.height * 0.03,
                            vertical: screenSize.height * 0.03),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFFFFFFF)),
                        child: Text(
                          controller.firstLetter.toUpperCase(),
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: AppColors.textmediumGreyColor)),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.height * 0.02,
                      ),
                      //name and the email id
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          Text(
                            controller.username,
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.logocolor)),
                          ),
                          //email id
                          Text(
                            controller.emailid,
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textmediumGreyColor)),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          //setting options
          //manage options
          SettingOptions(
              imageUrl: "assets/images/manage_category.svg",
              optionName: 'Manage Categories',
              onTap: () {}),
          SettingOptions(
              imageUrl: "assets/images/exportpdf.svg",
              optionName: 'Export to PDF',
              onTap: () {}),
          SettingOptions(
              imageUrl: "assets/images/currency.svg",
              optionName: "Choose currency",
              onTap: () {}),
          SettingOptions(
              imageUrl: "assets/images/language.svg",
              optionName: "Choose language",
              onTap: () {}),
          SettingOptions(
              imageUrl: "assets/images/questions.svg",
              optionName: "Frequently asked questions",
              onTap: () {}),
          //logout option
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LogoutDialogBox();
                  });
            },
            child: ListTile(
              leading: SvgPicture.asset("assets/images/logout.svg"),
              title: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}
