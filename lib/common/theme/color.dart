import 'package:flutter/material.dart';

class CustomColors {
  static const primaryBlue = Color(0xFF265AE8);
  static const accentGreen = Color(0xFF56BE88);
  static const primaryGreenGradient = LinearGradient(colors: [
    Color(0xFF9DFF9D),
    Color(0xFFE6FF82),
  ]);
  static const containerLightBlue = Color(0xFFF4F7FE);
  static const informationContainerGreen = Color(0xFFECFFEA);

  static const textBlack = Color(0xFF232323);
  static const textGrey = Color(0xFF8D8D8D);
  static const textDarkGreen = Color(0xFF1A3E01);

  static const inputBorder = Color(0xFFC0C4C3);

  static const divider = Color(0xFFD9D9D9);

  static const lightBlue = Color(0xFFEFF6FF);
  static const accentBlue = Color(0xFF1E40AF);

  static const pink = Color(0xFFFFDADD);

  static const containerBorderGrey = Color(0xFFE2E2EA);
  static const containerBorderSlate = Color(0xFFE5E7EB);
  static const containerBorderBlue = Color(0xFF001356);

  static final containerLightShadow = [
    BoxShadow(
      blurRadius: 2.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.12),
    ),
    BoxShadow(
      blurRadius: 3.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.08),
    ),
  ];
  static final cardShadow = [
    BoxShadow(
      blurRadius: 2.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.3),
    ),
    BoxShadow(
      blurRadius: 3.0,
      offset: Offset(0, 1),
      color: Colors.black.withOpacity(0.15),
    )
  ];
  static const containerGreenShadow = [
    BoxShadow(
      blurRadius: 7.5,
      offset: Offset(0, 2),
      color: CustomColors.primaryBlue,
    )
  ];
  static final containerSlateShadow = [
    BoxShadow(
      blurRadius: 6,
      offset: const Offset(0, 4),
      color: Colors.black.withOpacity(0.09),
    ),
  ];

  // Action
  static const alert = Color(0xFFe57373);

  // Color Theme
  static const amber50 = Color(0xFFFFFFEC);
  static const amber100 = Color(0xFFFEF3C7);
  static const amber400 = Color(0xFFfbbf24);
  static const amber500 = Color(0xFFFFEEC3);
  static const amber700 = Color(0xFF92400E);

  static const red50 = Color(0xFFfef2f2);
  static const red100 = Color(0xFFFEE2E2);
  static const red400 = Color(0xFFf87171);
  static const red700 = Color(0xFFb91c1c);

  static const slate50 = Color(0xFFf8fafc);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94a3b8);
  static const slate700 = Color(0xFF334155);
  static const slate900 = Color(0xFF0F172A);

  static const green50 = Color(0xFFf0fdf4);
  static const green400 = Color(0xFF4ade80);
  static const green700 = Color(0xFF15803d);

  static const purple200 = Color(0xFFE3E9FF);
}
