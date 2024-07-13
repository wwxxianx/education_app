import 'dart:ui';

import 'package:flutter/material.dart';

class ScaffoldMask extends StatelessWidget {
  const ScaffoldMask({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            color: Colors.black.withOpacity(0.17),
          ),
        ),
      ),
    );
  }
}
