import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/home/widgets/custom_fab.dart';
import 'package:expensify_app/app/modules/report/widgets/detailslisttile.dart';
import 'package:expensify_app/app/modules/report/widgets/detailsmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ReportController reportController = Get.put(ReportController());
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              "Statistics",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.headingsgreycolor)),
            ),
            actions: [
              //search icon
              SvgPicture.asset("assets/images/searchlogo.svg"),

              //three dots icon
              IconButton(onPressed: () {}, icon: Icon(Icons.menu))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                //date and the left and the right arrows
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.04,
                      vertical: screenSize.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //left arrow
                      SvgPicture.asset("assets/images/left_arrow.svg"),
                      //date picker and shower
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.height * 0.02,
                            vertical: screenSize.height * 0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.lightgreycolor),
                        child: Row(
                          children: [
                            //date picker logo
                            GestureDetector(
                                onTap: () {
                                  _selectDate(context, reportController);
                                },
                                child: SvgPicture.asset(
                                    "assets/images/datepicker.svg")),

                            SizedBox(
                              width: screenSize.height * 0.01,
                            ),
                            //show the picked date data
                            // ignore: unnecessary_cast
                            Obx(() => Text(
                                  '${reportController.formattedDate}',
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.textmediumGreyColor)),
                                ))
                          ],
                        ),
                      ),

                      //right arrow
                      SvgPicture.asset("assets/images/right_arrow.svg"),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                //overview text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.02),
                    child: Text(
                      'Overview',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textmediumGreyColor)),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                //bar plot
                Obx(() => LinearPercentIndicator(
                    lineHeight: screenSize.height * 0.05,
                    animation: true,
                    animationDuration: 1000,
                    percent: 1.0,
                    backgroundColor: AppColors.lightgreycolor,
                    barRadius: const Radius.circular(12),
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.blue, // Transportation
                        Colors.red, // Health
                        Colors.green, // Personal
                        Colors.purple, // Gifts
                        Colors.pink, // Electronics
                        Colors.yellow, // Caffe & Bar
                      ],
                      stops: [
                        reportController.transportationPercentage.value,
                        reportController.transportationPercentage.value +
                            reportController.healthPercentage.value,
                        reportController.transportationPercentage.value +
                            reportController.healthPercentage.value +
                            reportController.personalPercentage.value,
                        reportController.transportationPercentage.value +
                            reportController.healthPercentage.value +
                            reportController.personalPercentage.value +
                            reportController.giftsPercentage.value,
                        reportController.transportationPercentage.value +
                            reportController.healthPercentage.value +
                            reportController.personalPercentage.value +
                            reportController.giftsPercentage.value +
                            reportController.electronicsPercentage.value,
                        1.0,
                      ],
                    ))),

                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                //details text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.02),
                    child: Text(
                      "Details",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textmediumGreyColor)),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                //list using listview builder
                // Container(
                //   height: screenSize.height * 0.7,
                //   child: ListView.builder(
                //       scrollDirection: Axis.vertical,
                //       itemCount: details.length,
                //       itemBuilder: (context, index) {
                //         final stat_details = details;
                //         return DetailsListTile(
                //           expenseamount: stat_details[index].totalAmount,
                //           expensepercent: stat_details[index].percent,
                //           expensetitle: stat_details[index].expenseTitle,
                //           iconUrl: stat_details[index].iconUrl,
                //           transactions: stat_details[index].totalTransactions,
                //         );
                //       }),
                // )
                //lets try for loop(inside a column)
                Column(
                  children: [
                    //use for loop
                    for (int i = 0; i < details.length; i++)
                      DetailsListTile(
                          iconUrl: details[i].iconUrl,
                          expensetitle: details[i].expenseTitle,
                          transactions: details[i].totalTransactions,
                          expenseamount: details[i].totalAmount,
                          expensepercent: details[i].percent)
                  ],
                )
              ],
            ),
          ),
        ),
        //download report button
        Positioned(
            bottom: 50,
            child: CustomFAB(
              onTap: () {},
              title: 'Download report',
            ))
      ],
    );
  }

  _selectDate(BuildContext context, ReportController reportController) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      initialDate: reportController.selectedDate.value,
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
    if (pickedDate != null &&
        pickedDate != reportController.selectedDate.value) {
      reportController.updateDate(pickedDate);
    }
  }
}
