import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/modules/settings/model/questionsdata.dart';
import 'package:expensify_app/app/modules/settings/widgets/questionstile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AskedQuestions extends StatelessWidget {
  const AskedQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightgreycolor,
        appBar: AppBar(
          title: Text(
            'Q U E S T I O N S',
            style: GoogleFonts.inter(),
          ),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: questionsdata.length,
            itemBuilder: (context, index) {
              final questionData = questionsdata[index];
              return QuestionsTile(
                question: questionData.questions,
              );
            }));
  }
}
