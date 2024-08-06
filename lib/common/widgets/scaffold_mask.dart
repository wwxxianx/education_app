import 'dart:ui';

import 'package:flutter/material.dart';

class ScaffoldMask extends StatelessWidget {
  final bool isLoading;
  const ScaffoldMask({super.key, this.isLoading = false,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                color: Colors.black.withOpacity(0.17),
              ),
            ),
          ),
        ),
        if (isLoading)
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
