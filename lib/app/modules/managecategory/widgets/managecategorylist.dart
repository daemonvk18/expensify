import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageCategoryList extends StatelessWidget {
  const ManageCategoryList(
      {super.key,
      required this.iconUrl,
      required this.categoryname,
      required this.onTap});
  final String iconUrl;
  final String categoryname;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.01,
          horizontal: screenSize.height * 0.017),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ////row(logo,category)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //icon
                SvgPicture.asset(iconUrl),
                SizedBox(
                  width: screenSize.height * 0.017,
                ),
                Text(
                  categoryname,
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.logocolor)),
                )
              ],
            ),
            //edit option
            TextButton(
                onPressed: onTap,
                child: Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.fabcolor),
                ))
          ],
        ),
      ),
    );
  }
}
