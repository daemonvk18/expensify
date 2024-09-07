import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsTile extends StatelessWidget {
  const QuestionsTile({super.key, required this.question});
  final String question;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.height * 0.01,
            vertical: screenSize.height * 0.01),
        decoration: BoxDecoration(
            color: AppColors.lightthemeprimaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          question,
          style: GoogleFonts.inter(),
        ),
      ),
    );
  }
}
