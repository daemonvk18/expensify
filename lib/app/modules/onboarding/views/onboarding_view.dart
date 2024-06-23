import 'package:expensify_app/app/data/widgets/themeservice.dart';
import 'package:expensify_app/app/modules/onboarding/widgets/simple_tab_contrainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                ThemeService().switchTheme();
              },
              child: Icon(Icons.switch_access_shortcut)),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenSize.height * 0.25,
              ),
              SizedBox(
                child: SvgPicture.asset("assets/images/expensify_logo.svg"),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              //expensify text
              Text(
                "Expensify",
                style: GoogleFonts.inter(
                    textStyle:
                        TextStyle(fontSize: 46, fontWeight: FontWeight.bold)),
              ),
              Spacer(),
              //simple bar
              TabContainer()
            ],
          ),
        ));
  }
}
