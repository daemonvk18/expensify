import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:expensify_app/app/data/widgets/themeservice.dart';
import 'package:flutter/material.dart';

class TabContainer extends StatelessWidget {
  const TabContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = ThemeService().theme == ThemeData.dark();
    return Container(
      height: screenSize.height * 0.01,
      width: screenSize.width / 3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDarkMode
              ? AppColors.lightthemeprimaryColor
              : AppColors.darkthemePrimaryColor),
    );
  }
}
