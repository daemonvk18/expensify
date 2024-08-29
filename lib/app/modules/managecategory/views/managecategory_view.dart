import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/addcategory/views/addcategory_view.dart';
import 'package:expensify_app/app/modules/managecategory/widgets/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/managecategory_controller.dart';

class ManagecategoryView extends GetView<ManagecategoryController> {
  const ManagecategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ManagecategoryController controller =
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
                  children: controller.combinedCategories.map((category) {
                return _buildTile(category);
              }).toList()),
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

  Widget _buildTile(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _editCategoryDialog(category);
      },
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.network(category.logoUrl),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  category.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(Icons.edit),
            ],
          ),
        ),
      ),
    );
  }

  void _editCategoryDialog(CategoryModel category) {
    final TextEditingController nameController =
        TextEditingController(text: category.name);
    Get.defaultDialog(
        title: "Edit Category",
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: "Category Name"),
        ),
        confirm: TextButton(
            onPressed: () {
              bool isExpense = controller.expenseCategories.contains(category);
              controller.editCategory(
                  category.id, nameController.text.trim(), isExpense);
              Get.back();
            },
            child: Text(
              'save',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.fabcolor)),
            )),
        cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.headingsgreycolor)),
            )));
  }
}
