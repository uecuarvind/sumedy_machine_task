import 'package:flutter/material.dart';

import '../colors/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    //fontFamily: 'Quicksand',
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.primary,
    hintColor: AppColors.primary,
    focusColor: AppColors.primary,
    hoverColor: AppColors.primary,
    highlightColor: AppColors.primary,
    unselectedWidgetColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      color: AppColors.lightAppBar,
      foregroundColor: AppColors.primary,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black87),
    ),
  );

}
