import 'package:education_app/common/theme/color.dart';
import 'package:flutter/material.dart';

class IconWithBadge extends StatelessWidget {
  final Widget icon;
  final bool showBadge;

  const IconWithBadge({
    super.key,
    required this.icon,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (showBadge)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
                color: CustomColors.primaryBlue,
              ),
            ),
          ),
      ],
    );
  }
}
