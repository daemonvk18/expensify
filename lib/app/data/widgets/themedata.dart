import 'package:expensify_app/app/data/values/appcolors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.lightthemeprimaryColor,
  scaffoldBackgroundColor: AppColors.lightthemeprimaryColor,
  colorScheme: ColorScheme.light(
      primary: AppColors.lightthemeprimaryColor,
      onPrimary: AppColors.darkthemePrimaryColor),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightthemeprimaryColor,
    iconTheme: IconThemeData(color: AppColors.darkthemePrimaryColor),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkthemePrimaryColor),
  ),
);

final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.darkthemePrimaryColor,
    scaffoldBackgroundColor: AppColors.darkthemePrimaryColor,
    colorScheme: ColorScheme.dark(
        primary: AppColors.darkthemePrimaryColor,
        onPrimary: AppColors.lightthemeprimaryColor),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkthemePrimaryColor,
        iconTheme: IconThemeData(color: AppColors.lightthemeprimaryColor)),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightthemeprimaryColor),
    ));
