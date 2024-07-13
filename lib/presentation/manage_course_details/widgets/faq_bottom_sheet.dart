import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class FAQBottomSheet extends StatelessWidget {
  const FAQBottomSheet({super.key});

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
            child: Text("Save"),
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
                SvgPicture.asset("assets/icons/message-question-filled.svg"),
                6.kW,
                const Text(
                  "Course FAQ",
                  style: CustomFonts.titleMedium,
                ),
              ],
            ),
            20.kH,
            FAQForm(),
            12.kH,
            SizedBox(
              width: double.maxFinite,
              child: CustomButton(
                style: CustomButtonStyle.secondaryBlue,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HeroIcon(HeroIcons.plus, size: 20, color: CustomColors.primaryBlue,),
                    6.kW,
                    Text(
                      "Add Question",
                      style: CustomFonts.labelSmall.copyWith(color: CustomColors.primaryBlue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQForm extends StatelessWidget {
  const FAQForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFDCDCDC)),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomOutlinedTextfield(label: "Question:",),
          12.kH,
          CustomOutlinedTextfield(label: "Answer:",),
        ],
      ),
    );
  }
}