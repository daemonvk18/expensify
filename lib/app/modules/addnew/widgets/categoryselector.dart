import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addnew/controllers/addnew_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AddnewController controller = Get.find();
    return Container(
      height: screenSize.height * 0.6,
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * 0.02,
          vertical: screenSize.height * 0.02),
      child: Column(
        children: [
          Text(
            'Choose Category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          //gridviewbuilder
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.updateCategory(
                            controller.categories[index]['name']!);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                              controller.categories[index]['icon']!),
                          const SizedBox(height: 8),
                          Text(controller.categories[index]['name']!),
                        ],
                      ),
                    );
                  })),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.01,
                vertical: screenSize.height * 0.01),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.textmediumGreyColor),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Add new category',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fabcolor),
            ),
          ),
        ],
      ),
    );
  }
}
