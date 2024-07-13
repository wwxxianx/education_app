import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ErrorLabel extends StatelessWidget {
  final String? errorText;
  const ErrorLabel({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          errorText ?? "Something went wrong",
          style: CustomFonts.bodySmall.copyWith(color: CustomColors.alert),
        ),
        6.kW,
        const HeroIcon(
          HeroIcons.exclamationTriangle,
          size: 18,
          color: CustomColors.alert,
        ),
      ],
    );
  }
}
