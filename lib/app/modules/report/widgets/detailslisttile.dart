import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsListTile extends StatelessWidget {
  const DetailsListTile({
    super.key,
    required this.iconUrl,
    required this.expensetitle,
    required this.expenseamount,
  });
  final String iconUrl;
  final String expensetitle;
  final String expenseamount;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * 0.02,
          vertical: screenSize.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //row(icon,column(title,no of transctions))
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //icon
              SvgPicture.network(iconUrl),
              SizedBox(
                width: screenSize.height * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expensetitle,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.headingsgreycolor)),
                  ),
                ],
              )
            ],
          ),
          //amount,percentage
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '- \u20B9${expenseamount}',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.redcolor)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
