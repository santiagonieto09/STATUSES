import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1DB954);
  static const Color primaryDark = Color(0xFF128C7E);
  static const Color primaryLight = Color(0xFFDCF8C6);
  static const Color chatBg = Color(0xFFECE5DD);
  static const Color lightBg = Color(0xFFF0F2F5);
  static const Color darkBg = Color(0xFF111B21);
  static const Color secondaryText = Color(0xFF667781);
  static const Color accentGreen = Color(0xFF00A884);
  static const Color surfaceDark = Color(0xFF1F2C33);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color dividerDark = Color(0xFF313D45);
  static const Color dividerLight = Color(0xFFE9EDEF);
}

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

class AppShapes {
  AppShapes._();

  static const double cardRadius = 12.0;
  static const double buttonRadius = 24.0;
  static const double smallRadius = 8.0;
}
