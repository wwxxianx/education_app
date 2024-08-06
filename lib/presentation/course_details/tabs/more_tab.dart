import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/presentation/course_details/widgets/faq_bottom_sheet.dart';
import 'package:education_app/state_management/course_details/course_details_bloc.dart';
import 'package:education_app/state_management/course_details/course_details_event.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class CourseMoreTabContent extends StatelessWidget {
  final String courseId;
  const CourseMoreTabContent({
    super.key,
    required this.courseId,
  });

  void _showFAQBottomSheet(BuildContext context) {
    context.read<CourseDetailsBloc>().add(OnFetchCourseFAQ(courseId));
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        elevation: 0,
        context: context,
        builder: (modalContext) {
          return BlocProvider.value(
            value: BlocProvider.of<CourseDetailsBloc>(context),
            child: CourseFAQBottomSheet(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showFAQBottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: CustomColors.containerBorderSlate),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      HeroIcon(HeroIcons.chatBubbleLeftRight),
                      6.kW,
                      Text(
                        "FAQ",
                        style: CustomFonts.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
              12.kH,
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: CustomColors.containerBorderSlate),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      HeroIcon(HeroIcons.megaphone),
                      6.kW,
                      Text(
                        "Course Updates",
                        style: CustomFonts.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
