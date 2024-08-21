import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/searchoption/controllers/searchoption_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {super.key,
      required this.categoryname,
      required this.categorylogo,
      required this.searchoptionController});
  final String categorylogo;
  final String categoryname;
  final SearchoptionController searchoptionController;

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    return Obx(() {
      final isSelected =
          searchoptionController.selectedCategory.contains(categoryname);
      return GestureDetector(
          onTap: () =>
              searchoptionController.updateSelectedCategory(categoryname),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.height * 0.01,
                vertical: ScreenSize.height * 0.01),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.height * 0.015,
                  vertical: ScreenSize.height * 0.01),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.fabcolor
                          : AppColors.textmediumGreyColor),
                  color: isSelected
                      ? AppColors.lightbluecolor
                      : AppColors.lightthemeprimaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //logo
                  SvgPicture.asset(categorylogo),
                  Text(
                    categoryname,
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.headingsgreycolor)),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
