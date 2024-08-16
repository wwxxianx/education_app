import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/response/course/recommended_course.dart';
import 'package:education_app/presentation/course_details/course_details_screen.dart';
import 'package:education_app/state_management/explore/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:education_app/common/theme/typography.dart';

class RecommendedCourseFromPurchaseList extends StatelessWidget {
  const RecommendedCourseFromPurchaseList({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendedCourseFromPurchaseHistory =
        context.watch<ExploreBloc>().state.recommendedCourseFromPurchaseHistory;
    if (recommendedCourseFromPurchaseHistory
            is ApiResultSuccess<RecommendedCourseFromPurchaseHistory> &&
        recommendedCourseFromPurchaseHistory
            .data.recommendedCourses.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.kH,
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Text(
              'Because you purchased "${recommendedCourseFromPurchaseHistory.data.latestPurchase?.title ?? ""}"',
              style: CustomFonts.labelLarge,
            ),
          ),
          12.kH,
          SizedBox(
            height: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: recommendedCourseFromPurchaseHistory
                  .data.recommendedCourses.length,
              itemBuilder: (context, index) {
                final course = recommendedCourseFromPurchaseHistory
                    .data.recommendedCourses[index];
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
