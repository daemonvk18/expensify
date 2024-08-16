import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.put(NavbarController());
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Obx(() => controller.nabvarPages[controller.currentIndex.value]),
        bottomNavigationBar: Obx(() => Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.04,
                  vertical: screenSize.height * 0.01),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: AppColors.lightgreycolor, width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //report button
                  buildNavItems(
                      index: 0,
                      label: 'Report',
                      iconUrl: 'assets/images/stats_navbar.svg',
                      filledconUrl: 'assets/images/filled_report.svg'),
                  //home button
                  buildNavItems(
                      index: 1,
                      label: 'Home',
                      iconUrl: 'assets/images/home_navbar.svg',
                      filledconUrl: 'assets/images/filled_home.svg'),
                  //settings button
                  buildNavItems(
                      index: 2,
                      label: 'Settings',
                      iconUrl: 'assets/images/settings_navbar.svg',
                      filledconUrl: 'assets/images/filled_settings.svg')
                ],
              ),
            )),
      ),
    );
  }

  Widget buildNavItems(
      {required int index,
      required String label,
      required String iconUrl,
      required String filledconUrl}) {
    return GestureDetector(
      onTap: () {
        controller.toggleIndexofNavBar(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //icon
          controller.currentIndex.value == index
              ? SvgPicture.asset(filledconUrl)
              : SvgPicture.asset(iconUrl),
          //label
          Text(
            label,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: controller.currentIndex.value == index
                        ? FontWeight.w800
                        : FontWeight.w600,
                    color: AppColors.textmediumGreyColor)),
          )
        ],
      ),
    );
  }
}
