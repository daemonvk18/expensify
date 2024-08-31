import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addnew/widgets/categoryselector.dart';
import 'package:expensify_app/app/modules/addnew/widgets/incomecategory_selector.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/addnew_controller.dart';

class AddnewView extends GetView<AddnewController> {
  const AddnewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AddnewController addnewController = Get.put(AddnewController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightgreycolor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.headingsgreycolor,
              )),
          centerTitle: false,
          title: Text(
            'Add new',
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textmediumGreyColor)),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.height * 0.02,
              vertical: screenSize.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //drop down widget to select whether it is income or expense
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.headingsgreycolor),
                        borderRadius: BorderRadius.circular(12)),
                    child: DropdownButton<String>(
                      underline: null,
                      isExpanded: true,
                      value: addnewController.selectedType.value,
                      items: <String>['Expense', 'Income'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        addnewController.selectedType.value = newValue!;
                      },
                    ),
                  )),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              //select category option
              GestureDetector(
                onTap: () {
                  if (controller.selectedType == 'Expense') {
                    showExpenseCategorySelector(context);
                  } else {
                    showIncomeCategorySelector(context);
                  }
                },
                child: AbsorbPointer(
                  child: Obx(
                    () => TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.headingsgreycolor),
                            borderRadius: BorderRadius.circular(12)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.headingsgreycolor),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.fabcolor),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Category name',
                        labelStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.fabcolor)),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      controller: TextEditingController(
                          text: addnewController.categoryName.value),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              //add amount option
              TextFormField(
                controller: TextEditingController(
                    text: addnewController.amount.value.toString()),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.fabcolor),
                        borderRadius: BorderRadius.circular(12)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.headingsgreycolor),
                        borderRadius: BorderRadius.circular(12)),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.headingsgreycolor),
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Enter amount',
                    labelStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.fabcolor))),
                onChanged: (value) {
                  addnewController.amount.value = value;
                },
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              //description option
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.fabcolor),
                        borderRadius: BorderRadius.circular(12)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.fabcolor)),
                    labelText: 'Description (Optional)'),
                onChanged: (value) {
                  addnewController.title.value = value;
                },
              ),
              Spacer(),
              //add the expense button
              Obx(() => Visibility(
                  visible: addnewController.amount.value.isNotEmpty,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.height * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          controller.addTransaction(
                              addnewController.selectedType.value,
                              addnewController.categoryName.value,
                              addnewController.amount.value,
                              addnewController.title.value);
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                              color: AppColors.fabcolor,
                              borderRadius: BorderRadius.circular(54)),
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02),
                          child: Text(
                            controller.selectedType.value == 'Expense'
                                ? "Add expense"
                                : "Add income",
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightthemeprimaryColor)),
                          ),
                        ),
                      ),
                    ),
                  ))),
            ],
          ),
        ));
  }

  void showExpenseCategorySelector(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (context) => CategorySelector());
  }

  void showIncomeCategorySelector(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (context) => IncomeCategory());
  }
}
