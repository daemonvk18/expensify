import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/searchoption_controller.dart';

class SearchoptionView extends GetView<SearchoptionController> {
  const SearchoptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search for notes, categories or labels',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textmediumGreyColor)),
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'SearchoptionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
