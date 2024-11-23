import 'package:flutter/material.dart';
import 'package:images/presentation/styles/app_colors.dart';

final lightThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    secondary: AppColors.secondary,
  ),
  appBarTheme: AppBarTheme(
    color: AppColors.primary,
  ),
);

