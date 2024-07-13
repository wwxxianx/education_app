import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final bool showBadge;

  const CustomListTile({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: padding,
        child: Row(
          children: [
            if (leading != null) leading!,
            if (leading != null) 8.kW,
            if (title != null) title!,
            if (showBadge) 4.kW,
            if (showBadge)
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: CustomColors.primaryBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
              ),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
