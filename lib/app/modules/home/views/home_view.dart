import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          //leave some space
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          //row(kitty,search logo,account_photo)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //row(logo,logotext)
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenSize.height * 0.01),
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                              "assets/images/expensify_logo.svg")),
                    ),
                    //logo text
                    Text(
                      "expensify",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.logocolor)),
                    )
                  ],
                ),
                //row(search logo,account photo)
                Row(
                  children: [
                    //search the logo
                    SvgPicture.asset('assets/images/searchlogo.svg'),
                    SizedBox(
                      width: screenSize.width * 0.03,
                    ),
                    //account logo
                    CircleAvatar(
                      radius: screenSize.height * 0.02,
                      backgroundColor: AppColors.textmediumGreyColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          //date and the left and the right arrows
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.02,
                vertical: screenSize.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left arrow
                SvgPicture.asset("assets/images/left_arrow.svg"),
                //date picker and shower
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightgreycolor),
                  child: Row(
                    children: [
                      //date picker logo
                      GestureDetector(
                          onTap: () {
                            _selectDate(context, homeController);
                          },
                          child:
                              SvgPicture.asset("assets/images/datepicker.svg")),

                      SizedBox(
                        width: screenSize.height * 0.01,
                      ),
                      //show the picked date data
                      // ignore: unnecessary_cast
                      Obx(() => Text('${homeController.formattedDate}'))
                    ],
                  ),
                ),

                //right arrow
                SvgPicture.asset("assets/images/right_arrow.svg"),
              ],
            ),
          )
        ],
      ),
    ));
  }

  _selectDate(BuildContext context, HomeController homeController) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      initialDate: homeController.selectedDate.value,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              hintColor: Colors.blue,
              colorScheme: ColorScheme.light(primary: Colors.blue),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    if (pickedDate != null && pickedDate != homeController.selectedDate.value) {
      homeController.updateDate(pickedDate);
    }
  }
}
