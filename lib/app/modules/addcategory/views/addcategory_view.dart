import 'package:dotted_border/dotted_border.dart';
import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addcategory/widgets/addnewcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/addcategory_controller.dart';

class AddcategoryView extends GetView<AddcategoryController> {
  const AddcategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AddcategoryController addcategoryController =
        Get.put(AddcategoryController());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightgreycolor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Add new category'),
          centerTitle: false,
        ),
        body: Column(
          children: [
            SizedBox(height: screenSize.height * 0.02),
            //row(add icon and category name)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //icon
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        addcategoryController.isTapped.value = true;
                        showIconSelector(context, addcategoryController);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        //backgroundColor: AppColors.textmediumGreyColor,
                        child: addcategoryController.selectedIcon.isEmpty
                            ? DottedBorder(
                                dashPattern: [8, 4],
                                strokeWidth: 2,
                                borderType: BorderType.Circle,
                                color: addcategoryController.isTapped == true
                                    ? AppColors.headingsgreycolor
                                    : AppColors.fabcolor,
                                child: Container(
                                  padding:
                                      EdgeInsets.all(screenSize.height * 0.015),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightgreycolor,
                                      shape: BoxShape.circle),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.textmediumGreyColor,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.lightthemeprimaryColor,
                                      weight: 3,
                                    ),
                                  ),
                                ),
                              )
                            : SvgPicture.asset(
                                addcategoryController.selectedIcon.value),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.height * 0.01,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.7,
                    child: TextField(
                      cursorColor: Color(0xFF000000),
                      onChanged: addcategoryController.updateCategoryName,
                      decoration: InputDecoration(
                          labelText: 'Category name',
                          labelStyle: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textmediumGreyColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.textmediumGreyColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.textmediumGreyColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.textmediumGreyColor))),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Obx(() => Visibility(
                visible: addcategoryController.isformValid,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02,
                        horizontal: screenSize.height * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.fabcolor,
                          borderRadius: BorderRadius.circular(54)),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.02),
                      width: screenSize.width,
                      child: Text(
                        'Add new Category',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightthemeprimaryColor)),
                      ),
                    ),
                  ),
                )))
          ],
        ));
  }

  void showIconSelector(
      BuildContext context, AddcategoryController controller) {
    showModalBottomSheet(
        context: context,
        builder: (context) => AddCategory(
              controller: controller,
            ));
  }
}
