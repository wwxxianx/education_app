import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class TextWithGradientBGShape extends StatelessWidget {
  final Widget text;
  final double width;
  const TextWithGradientBGShape({
    super.key,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        TextGradientBGShape(
          width: width,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 3),
          child: text,
        ),
      ],
    );
  }
}

class TextGradientBGShape extends StatelessWidget {
  final double width;
  const TextGradientBGShape({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        width,
        10.2.toDouble(),
      ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.4666667);
    path_0.lineTo(size.width * 0.01382749, size.height * 0.4448567);
    path_0.cubicTo(
        size.width * 0.3394225,
        size.height * -0.06870644,
        size.width * 0.6747746,
        size.height * -0.06129000,
        size.width,
        size.height * 0.4666667);
    path_0.lineTo(size.width, size.height * 0.4666667);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.cubicTo(
        size.width * 0.6747746,
        size.height * 0.4720433,
        size.width * 0.3394225,
        size.height * 0.4646267,
        size.width * 0.01382748,
        size.height * 0.9781900);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.4666667);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.1029411, size.height * 0.6666667),
      Offset(size.width * 0.9216296, size.height * 0.6128267),
      [
        Color(0xff9BC0F9).withOpacity(1),
        Color(0xff387EE7).withOpacity(1),
        Color(0xff9BC0F9).withOpacity(1)
      ],
      [0, 0.5, 1],
    );
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
