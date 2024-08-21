import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addcategory/controllers/addcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key, required this.controller});
  final AddcategoryController controller;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * 0.02,
          vertical: screenSize.height * 0.02),
      height: screenSize.height * 0.5,
      decoration: BoxDecoration(
          color: AppColors.lightthemeprimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Expanded(
              child: GridView.builder(
                  itemCount: controller.combinedData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 20,
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    final iconPath =
                        controller.combinedData[index]['icon'].toString();
                    return GestureDetector(
                      onTap: () {
                        controller.updateImagePath(iconPath);
                        Get.back();
                      },
                      child: SvgPicture.asset(iconPath),
                    );
                  }))
        ],
      ),
    );
  }
}
