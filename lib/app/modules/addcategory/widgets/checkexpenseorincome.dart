import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addcategory/controllers/addcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckExpenseOrIncome extends StatelessWidget {
  const CheckExpenseOrIncome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AddcategoryController controller = Get.find();
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.height * 0.02,
            vertical: screenSize.height * 0.02),
        decoration: BoxDecoration(color: AppColors.lightthemeprimaryColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //text to check whether you want to add it in the expense category or income category
            Text("Do you want to add it as a expense or income?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //income button
                GestureDetector(
                  onTap: () {
                    if (controller.isexpense.value == true) {
                      controller.isexpense.value = false;
                    }
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.01,
                        vertical: screenSize.height * 0.01),
                    decoration: BoxDecoration(color: AppColors.fabcolor),
                    child: Text('Income'),
                  ),
                ),
                //expense button
                GestureDetector(
                  onTap: () {
                    if (controller.isexpense.value == false) {
                      controller.isexpense.value = true;
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.01,
                        vertical: screenSize.height * 0.01),
                    decoration: BoxDecoration(color: AppColors.fabcolor),
                    child: Text('Expense'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
