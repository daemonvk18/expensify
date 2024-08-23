import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addcategory/views/addcategory_view.dart';
import 'package:expensify_app/app/modules/managecategory/widgets/managecategorylist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/managecategory_controller.dart';

class ManagecategoryView extends GetView<ManagecategoryController> {
  const ManagecategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ManagecategoryController managecategoryController =
        Get.put(ManagecategoryController());
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.lightgreycolor,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back)),
              title: Text(
                'Manage Categories',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.headingsgreycolor)),
              ),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0;
                      i < managecategoryController.combinedList.length;
                      i++)
                    ManageCategoryList(
                      iconUrl: managecategoryController.combinedList[i]['icon']
                          .toString(),
                      categoryname: managecategoryController.combinedList[i]
                              ['name']
                          .toString(),
                      onTap: () {},
                    )
                ],
              ),
            )),
        //add new category
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.02,
              horizontal: screenSize.height * 0.02),
          child: GestureDetector(
            onTap: () {
              Get.to(() => AddcategoryView());
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.fabcolor,
                  borderRadius: BorderRadius.circular(54)),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              width: screenSize.width,
              child: Text(
                'Add new Category',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightthemeprimaryColor)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
