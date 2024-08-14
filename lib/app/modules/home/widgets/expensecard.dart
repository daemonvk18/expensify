import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(
      {super.key,
      required this.imageUrl,
      required this.category,
      required this.title,
      required this.amount});
  final String imageUrl;
  final String title;
  final String category;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //row(with category logo and column(with title and category name))
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              if (imageUrl == "") Container() else SvgPicture.asset(imageUrl),
              SizedBox(
                width: 10.0,
              ),
              //column
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: category == ""
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.logocolor)),
                  ),
                  Text(
                    category,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.categorynameColor)),
                  )
                ],
              )
            ],
          ),
          //amount spend
          Text(
            "- \u20B9${amount}",
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: title == 'T O D A Y' || title == 'Y E S T E R D A Y'
                        ? AppColors.textmediumGreyColor
                        : AppColors.redcolor)),
          )
        ],
      ),
    );
  }
}
