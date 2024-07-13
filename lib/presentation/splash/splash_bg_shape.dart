import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class SplashBgShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6914760, size.height * 0.1569027);
    path_0.cubicTo(
        size.width * 0.7537948,
        size.height * 0.2020884,
        size.width * 0.8266070,
        size.height * 0.2289384,
        size.width * 0.8771572,
        size.height * 0.2873862);
    path_0.cubicTo(
        size.width * 0.9339345,
        size.height * 0.3530299,
        size.width * 0.9938515,
        size.height * 0.4259063,
        size.width * 0.9995852,
        size.height * 0.5131429);
    path_0.cubicTo(
        size.width * 1.005362,
        size.height * 0.6011116,
        size.width * 0.9497467,
        size.height * 0.6786161,
        size.width * 0.9079389,
        size.height * 0.7558527);
    path_0.cubicTo(
        size.width * 0.8661703,
        size.height * 0.8330179,
        size.width * 0.8302052,
        size.height * 0.9197812,
        size.width * 0.7554236,
        size.height * 0.9642098);
    path_0.cubicTo(
        size.width * 0.6809520,
        size.height * 1.008451,
        size.width * 0.5891878,
        size.height * 1.001152,
        size.width * 0.5030699,
        size.height * 0.9963750);
    path_0.cubicTo(
        size.width * 0.4217563,
        size.height * 0.9918661,
        size.width * 0.3423266,
        size.height * 0.9754732,
        size.width * 0.2700576,
        size.height * 0.9372946);
    path_0.cubicTo(
        size.width * 0.1966987,
        size.height * 0.8985402,
        size.width * 0.1315528,
        size.height * 0.8452723,
        size.width * 0.08523057,
        size.height * 0.7756295);
    path_0.cubicTo(
        size.width * 0.03755223,
        size.height * 0.7039509,
        size.width * 0.009031179,
        size.height * 0.6210357,
        size.width * 0.002308262,
        size.height * 0.5347634);
    path_0.cubicTo(
        size.width * -0.004651004,
        size.height * 0.4454594,
        size.width * 0.002517528,
        size.height * 0.3521893,
        size.width * 0.04616987,
        size.height * 0.2743812);
    path_0.cubicTo(
        size.width * 0.08955677,
        size.height * 0.1970460,
        size.width * 0.1688961,
        size.height * 0.1517161,
        size.width * 0.2434179,
        size.height * 0.1049987);
    path_0.cubicTo(
        size.width * 0.3184044,
        size.height * 0.05798973,
        size.width * 0.3946930,
        size.height * -0.009110982,
        size.width * 0.4822140,
        size.height * 0.001027460);
    path_0.cubicTo(
        size.width * 0.5696026,
        size.height * 0.01115121,
        size.width * 0.6198515,
        size.height * 0.1049719,
        size.width * 0.6914760,
        size.height * 0.1569027);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4725284, size.height * 9.169955e-7),
        Offset(size.width * 0.4725284, size.height),
        [Color(0xff678FFB).withOpacity(1), Color(0xffADCEF4).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
