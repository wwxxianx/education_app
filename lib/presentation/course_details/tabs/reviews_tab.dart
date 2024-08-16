import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/presentation/my_learning_details/widgets/review_bottom_sheet.dart';
import 'package:education_app/state_management/course_review/course_review_bloc.dart';
import 'package:education_app/state_management/course_review/course_review_event.dart';
import 'package:education_app/state_management/course_review/course_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseReviewsTabContent extends StatelessWidget {
  final String courseId;
  const CourseReviewsTabContent({
    super.key,
    required this.courseId,
  });

  // Widget _buildUserReviews(ApiResult<Course> courseResult) {
  //   if (courseResult is ApiResultSuccess<Course>) {
  //     return ListView.builder(
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       padding: const EdgeInsets.only(top: 0),
  //       itemCount: courseResult.data.reviews.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //             margin: const EdgeInsets.only(bottom: 20),
  //             child:
  //                 UserReviewItem(userReview: courseResult.data.reviews[index]));
  //       },
  //     );
  //   }
  //   return Text("Loading...");
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseReviewBloc(
        createCourseReview: serviceLocator(),
        fetchCourseReviews: serviceLocator(),
      )..add(OnFetchCourseReview(courseId: courseId)),
      child: BlocBuilder<CourseReviewBloc, CourseReviewState>(
        builder: (context, state) {
          final courseReviewResult = state.courseReviewResult;
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Course Reviews",
                  style: CustomFonts.titleMedium,
                ),
                12.kH,
                if (courseReviewResult is ApiResultLoading)
                  const CircularProgressIndicator(),
                if (courseReviewResult is ApiResultSuccess<List<UserReview>>)
                  CourseReviewList(
                    reviews: courseReviewResult.data,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

// class UserReviewItem extends StatelessWidget {
//   final UserReview userReview;
//   const UserReviewItem({
//     super.key,
//     required this.userReview,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Avatar header
//         Row(
//           children: [
//             Avatar(
//               imageUrl: '',
//               size: 38,
//             ),
//             4.kW,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   userReview.user.fullName,
//                   style: CustomFonts.labelSmall,
//                 ),
//                 2.kH,
//                 Row(
//                   children: [
//                     ReviewStar(
//                       starSize: 14,
//                       review: userReview.reviewRating.toDouble(),
//                     ),
//                     4.kW,
//                     Text(
//                       userReview.createdAt.toTimeAgo(),
//                       style: CustomFonts.bodyExtraSmall
//                           .copyWith(color: CustomColors.textGrey),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//         8.kH,
//         Flexible(
//           child: Text(
//             userReview.reviewContent,
//             style: CustomFonts.bodySmall,
//           ),
//         )
//       ],
//     );
//   }
// }
