import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screensize.height * 0.1),
      child: Container(
        height: 60,
        width: 140,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.fabcolor,
            borderRadius: BorderRadius.circular(44),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  color: Colors.grey.shade400,
                  spreadRadius: 3,
                  blurRadius: 10)
            ]),
        padding: EdgeInsets.symmetric(
            horizontal: screensize.height * 0.02,
            vertical: screensize.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //add icon
            SvgPicture.asset("assets/images/add_new.svg"),
            //add new
            Text(
              "Add new",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF))),
            )
          ],
        ),
      ),
    );
  }
}
