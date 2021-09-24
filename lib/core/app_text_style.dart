import 'app_theme.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();
  static const TextStyle boldTitle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.eclipse);
  static TextStyle boldTitleAlpha90 = TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.eclipse.withAlpha(90),
      fontSize: 18);
  static const TextStyle boldText = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.eclipse);
  static const TextStyle normalText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
}
