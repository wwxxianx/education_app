import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeforeStartingCourseContent extends StatelessWidget {
  final Course course;
  const BeforeStartingCourseContent({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    if (course.instructor.bankAccount?.payoutsEnabled ?? false) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Before starting your course",
          style: CustomFonts.labelMedium,
        ),
        12.kH,
        GestureDetector(
          onTap: () {
            // _navigateToBankScreen(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 1.4,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: CustomColors.containerBorderSlate),
                boxShadow: CustomColors.containerSlateShadow),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/credit-card-filled.svg'),
                    4.kW,
                    const Text(
                      "Bank Account",
                      style: CustomFonts.labelSmall,
                    ),
                    const Spacer(),
                    // BankAccountChip(user: campaignResult.data.user),
                  ],
                ),
                6.kH,
                const Text(
                  'Before you receive any donation, please set up a valid bank account in order to receive donation.',
                  style: CustomFonts.bodySmall,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
