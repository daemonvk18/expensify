import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/searchoption/widgets/categorycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import '../controllers/searchoption_controller.dart';

class SearchoptionView extends GetView<SearchoptionController> {
  const SearchoptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final SearchoptionController searchoptionController =
        Get.put(SearchoptionController());
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
            title: TextFormField(
              cursorColor: AppColors.logocolor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for notes,category or label"),
              onChanged: searchoptionController.updateSeachText,
            )),
        body: Column(
          children: [
            Container(
              height: screenSize.height < 700
                  ? screenSize.height * 0.08
                  : screenSize.height * 0.07,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: AppColors.textmediumGreyColor))),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0;
                      i < searchoptionController.categories.length;
                      i++)
                    CategoryContainer(
                        categoryname: searchoptionController.categories[i][0],
                        categorylogo: searchoptionController.categories[i][1],
                        searchoptionController: searchoptionController)
                ],
              ),
            ),
            //show the filtered data here
            Expanded(child: Obx(
              () {
                final expenses = searchoptionController.filteredExpenses;
                return ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ListTile(
                        leading: SvgPicture.asset(expense.expenseCategorylogo),
                        title: Text(expense.expenseTitle),
                        subtitle: Text(expense.expenseCategory),
                        trailing: Text('- ' + '\u20B9${expense.amount}'),
                      );
                    });
              },
            ))
          ],
        ));
  }
}
