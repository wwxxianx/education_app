import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/state_management/course_details/course_details_bloc.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class CourseDetailsAboutTab extends StatelessWidget {
  const CourseDetailsAboutTab({super.key});

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
          child: CourseAboutContent(
            courseResult: courseResult,
          ),
        );
      },
    );
  }
}

class CourseAboutContent extends StatelessWidget {
  final ApiResult<Course> courseResult;
  const CourseAboutContent({super.key, required this.courseResult});

  Widget _buildLoadingList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: const Skeleton(
            width: double.maxFinite,
            height: Dimensions.loadingBodyHeight,
          ),
        );
      },
    );
  }

  Widget _buildLearningContent(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: courseResult.data.topics.length,
        itemBuilder: (context, index) {
          final topic = courseResult.data.topics[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeroIcon(
                HeroIcons.check,
                style: HeroIconStyle.mini,
                size: 20,
              ),
              4.kW,
              Flexible(child: Text(topic)),
            ],
          );
        },
      );
    }
    return _buildLoadingList();
  }

  Widget _buildRequirementsContent(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: courseResult.data.requirements.length,
        itemBuilder: (context, index) {
          final requirement = courseResult.data.requirements[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeroIcon(
                HeroIcons.check,
                style: HeroIconStyle.mini,
                size: 20,
              ),
              4.kW,
              Flexible(child: Text(requirement)),
            ],
          );
        },
      );
    }
    return _buildLoadingList();
  }

  Widget _buildOverviewContent(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return Text(courseResult.data.description);
    }
    return _buildLoadingList();
  }

  Widget _buildInstructorContent(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(
            imageUrl:
                courseResult.data.instructor.instructorProfile?.profileImageUrl,
            placeholder: courseResult.data.instructorDisplayName[0],
          ),
          8.kW,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    courseResult.data.instructorDisplayName,
                    style: CustomFonts.labelMedium,
                  ),
                  4.kW,
                  const HeroIcon(
                    HeroIcons.checkBadge,
                    size: 20.0,
                    style: HeroIconStyle.solid,
                    color: CustomColors.primaryBlue,
                  ),
                ],
              ),
              if (courseResult.data.instructor.instructorProfile?.title != null)
                Text(
                  courseResult.data.instructor.instructorProfile!.title,
                  style: CustomFonts.bodySmall.copyWith(
                    color: CustomColors.textGrey,
                  ),
                ),
            ],
          )
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Skeleton(
          width: 40,
          height: 40,
          radius: 100,
        ),
        8.kW,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Skeleton(
                  width: 40,
                  height: Dimensions.loadingBodyHeight,
                ),
                4.kW,
                const HeroIcon(
                  HeroIcons.checkBadge,
                  size: 20.0,
                  style: HeroIconStyle.solid,
                  color: CustomColors.primaryBlue,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Instructor
        const Text(
          "Instructor",
          style: CustomFonts.titleMedium,
        ),
        12.kH,
        _buildInstructorContent(courseResult),
        28.kH,
        // What you'll learn
        const Text(
          "What you'll learn",
          style: CustomFonts.titleMedium,
        ),
        8.kH,
        _buildLearningContent(courseResult),

        28.kH,
        // Requirements
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Requirements",
            style: CustomFonts.titleMedium,
          ),
        ),
        8.kH,
        _buildRequirementsContent(courseResult),
        28.kH,
        // Overview
        const Text(
          "Overview",
          style: CustomFonts.titleMedium,
        ),
        8.kH,
        _buildOverviewContent(courseResult),
      ],
    );
  }
}
