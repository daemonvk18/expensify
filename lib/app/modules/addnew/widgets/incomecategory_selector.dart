import 'package:expensify_app/app/modules/addnew/controllers/addnew_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AddnewController controller = Get.find();
    return Container(
      height: screenSize.height * 0.4,
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
                  itemCount: controller.incomeCategories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.updateIncomeCategory(
                            controller.incomeCategories[index]['name']!);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                              controller.incomeCategories[index]['icon']!),
                          const SizedBox(height: 8),
                          Text(controller.incomeCategories[index]['name']!),
                        ],
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
