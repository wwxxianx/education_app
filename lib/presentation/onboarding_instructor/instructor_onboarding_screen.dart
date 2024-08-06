import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/presentation/onboarding_instructor/widgets/create_instructor_profile_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstructorOnboardingScreen extends StatelessWidget {
  static const route = '/instructor-onboarding';
  const InstructorOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
          vertical: 10,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: CustomColors.containerBorderGrey))),
        child: CustomButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              elevation: 0,
              context: context,
              builder: (context) {
                return CreateInstructorProfileBottomSheet();
              },
            );
          },
          child: Text("Create Instructor Account"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20, bottom: Dimensions.bottomActionBarHeight + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  "assets/images/instructor-onboarding-knowledge.svg"),
              Text(
                "Share Your Knowledge\nwith the World",
                style: CustomFonts.titleExtraLarge,
                textAlign: TextAlign.center,
              ),
              12.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Empower learners everywhere by sharing your unique insights and expertise. Create engaging courses that inspire and educate.",
                  style: CustomFonts.labelMedium
                      .copyWith(color: CustomColors.slate400),
                  textAlign: TextAlign.center,
                ),
              ),
              40.kH,
              Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF4F74D8),
                ),
                child: Column(
                  children: [
                    Text(
                      "Manage Your Courses\nOn the Go",
                      style: CustomFonts.titleExtraLarge
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 300,
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                            right: 20,
                            top: 10,
                            child: Image.asset(
                              'assets/images/instructor-mobile-mockup.png',
                              width: 300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              40.kH,
              SvgPicture.asset("assets/images/instructor-onboarding-earn.svg"),
              Text(
                "Grow Your Impact and Earnings",
                style: CustomFonts.titleExtraLarge,
                textAlign: TextAlign.center,
              ),
              12.kH,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding),
                child: Text(
                  "Reach a global audience and expand your influence. Our platform provides the tools you need to grow your following and increase your income.",
                  style: CustomFonts.labelMedium
                      .copyWith(color: CustomColors.slate400),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
