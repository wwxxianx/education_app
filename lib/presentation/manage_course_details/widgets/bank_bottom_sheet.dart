import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CertificateBottomSheet extends StatelessWidget {
  const CertificateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.9,
      footer: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
          vertical: 10,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: CustomButton(
            onPressed: () {},
            child: Text("Create"),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.screenHorizontalPadding,
          right: Dimensions.screenHorizontalPadding,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/credit-card-filled.svg"),
                6.kW,
                const Text(
                  "My Bank",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
            20.kH,
            CustomOutlinedTextfield(),
          ],
        ),
      ),
    );
  }
}
