import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:flutter/material.dart';

enum CustomChipStyle {
  slate,
  amber,
  green,
  red,
}

extension CustomChipStyleExtension on CustomChipStyle {
  Color get bgColor {
    switch (this) {
      case CustomChipStyle.slate:
        return CustomColors.slate50;
      case CustomChipStyle.amber:
        return CustomColors.amber50;
      case CustomChipStyle.green:
        return CustomColors.green50;
      case CustomChipStyle.red:
        return CustomColors.red50;
    }
  }

  Color get foregroundColor {
    switch (this) {
      case CustomChipStyle.slate:
        return CustomColors.slate700;
      case CustomChipStyle.amber:
        return CustomColors.amber700;
      case CustomChipStyle.green:
        return CustomColors.green700;
      case CustomChipStyle.red:
        return CustomColors.red700;
    }
  }

  Color get borderColor {
    switch (this) {
      case CustomChipStyle.slate:
        return CustomColors.slate400;
      case CustomChipStyle.amber:
        return CustomColors.amber400;
      case CustomChipStyle.green:
        return CustomColors.green400;
      case CustomChipStyle.red:
        return CustomColors.red400;
    }
  }
}

class CustomChip extends StatelessWidget {
  final Widget child;
  final CustomChipStyle style;
  const CustomChip({
    super.key,
    required this.child,
    this.style = CustomChipStyle.slate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: style.bgColor,
        border: Border.all(color: style.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DefaultTextStyle.merge(
        style:
            CustomFonts.labelExtraSmall.copyWith(color: style.foregroundColor),
        child: child,
      ),
    );
  }
}
