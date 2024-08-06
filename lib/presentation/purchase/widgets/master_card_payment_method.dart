import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MasterCardPaymentMethodItem extends StatelessWidget {
  const MasterCardPaymentMethodItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/mastercard.png",
          ),
          18.kW,
          const Text(
            "Mastercard",
            style: CustomFonts.labelMedium,
          ),
          const Spacer(),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: CustomColors.primaryBlue,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: const HeroIcon(
              HeroIcons.check,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
