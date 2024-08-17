import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/addnew_controller.dart';

class AddnewView extends GetView<AddnewController> {
  const AddnewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textmediumGreyColor)),
        ),
      ),
      body: const Center(
        child: Text(
          'AddnewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
