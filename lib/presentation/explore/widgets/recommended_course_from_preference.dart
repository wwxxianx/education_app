import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/course_details/course_details_screen.dart';
import 'package:education_app/state_management/explore/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecommendedCourseFromPreference extends StatelessWidget {
  const RecommendedCourseFromPreference({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendedCourseFromPreference =
        context.watch<ExploreBloc>().state.recommendedCourseFromPreference;
    if (recommendedCourseFromPreference is ApiResultSuccess<List<Course>> &&
        recommendedCourseFromPreference.data.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          34.kH,
          const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Text(
              'Courses you might\nbe interested',
              style: CustomFonts.labelLarge,
            ),
          ),
          12.kH,
          SizedBox(
            height: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: recommendedCourseFromPreference.data.length,
              itemBuilder: (context, index) {
                final course = recommendedCourseFromPreference.data[index];
                return Container(
                  key: ValueKey(course.id),
                  margin: EdgeInsets.only(
                    right: 16,
                    left: index == 0 ? Dimensions.screenHorizontalPadding : 0.0,
                  ),
                  child: CourseCard(
                    onPressed: () {
                      context.push(CourseDetailsScreen.generateRoute(
                          courseId: course.id));
                    },
                    course: course,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
