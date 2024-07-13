import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/button/date_picker_button.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';

class DiscountForm extends StatefulWidget {
  const DiscountForm({super.key});

  @override
  State<DiscountForm> createState() => _DiscountFormState();
}

class _DiscountFormState extends State<DiscountForm> {
  bool bool1 = false;
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: CustomColors.containerBorderSlate),
                boxShadow: CustomColors.containerSlateShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discount",
                    style: CustomFonts.labelMedium,
                  ),
                  8.kH,
                  Text(
                    'Original Price',
                    style: CustomFonts.bodySmall
                        .copyWith(color: CustomColors.textGrey),
                  ),
                  4.kH,
                  Text(
                    'RM199',
                    style: CustomFonts.bodySmall
                        .copyWith(color: CustomColors.textGrey),
                  ),
                  8.kH,
                  CustomOutlinedTextfield(
                    label: "After discount:",
                  ),
                ],
              ),
            ),
            20.kH,
            DatePickerButton(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: CustomColors.containerBorderSlate),
                boxShadow: CustomColors.containerSlateShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Switch(
                        // This bool value toggles the switch.
                        value: bool1,
                        activeColor: Colors.white,
                        activeTrackColor: CustomColors.slate900,
                        onChanged: (bool value) {
                          setState(() {
                            bool1 = value;
                          });
                        },
                      ),
                      6.kW,
                      Text(
                        'Limited Offer',
                        style: CustomFonts.labelSmall,
                      ),
                    ],
                  ),
                  4.kH,
                  Text(
                    'This discount will be only available to the number of sales you specified.',
                    style: CustomFonts.bodyExtraSmall
                        .copyWith(color: CustomColors.textGrey),
                  ),
                  8.kH,
                  CustomOutlinedTextfield(
                    label: "Numbers of offer:",
                  ),
                ],
              ),
            ),
            20.kH,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: CustomColors.containerBorderSlate),
                boxShadow: CustomColors.containerSlateShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Switch(
                        // This bool value toggles the switch.
                        value: bool1,
                        activeColor: Colors.white,
                        activeTrackColor: CustomColors.slate900,
                        onChanged: (bool value) {
                          setState(() {
                            bool1 = value;
                          });
                        },
                      ),
                      6.kW,
                      Text(
                        'Expiration',
                        style: CustomFonts.labelSmall,
                      ),
                    ],
                  ),
                  4.kH,
                  Text(
                    'The discount is only available before the time you specified.',
                    style: CustomFonts.bodyExtraSmall
                        .copyWith(color: CustomColors.textGrey),
                  ),
                  8.kH,
                ],
              ),
            ),
            12.kH,
            SizedBox(
              width: double.maxFinite,
              child: CustomButton(
                onPressed: () {},
                child: Text("Create"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
