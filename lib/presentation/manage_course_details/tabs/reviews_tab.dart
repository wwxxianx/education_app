import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCourseReviewsTabContent extends StatelessWidget {
  const ManageCourseReviewsTabContent({super.key});

  Widget _buildUserReviews(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        itemCount: courseResult.data.reviews.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child:
                  UserReviewItem(userReview: courseResult.data.reviews[index]));
        },
      );
    }
    return Text("Loading...");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildUserReviews(courseResult),
            ],
          ),
        );
      },
    );
  }
}

class UserReviewItem extends StatelessWidget {
  final UserReview userReview;
  const UserReviewItem({
    super.key,
    required this.userReview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar header
        Row(
          children: [
            Avatar(
              imageUrl: '',
              size: 38,
            ),
            4.kW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userReview.user.fullName,
                  style: CustomFonts.labelSmall,
                ),
                2.kH,
                Row(
                  children: [
                    ReviewStar(
                      starSize: 14,
                      review: userReview.reviewRating.toDouble(),
                    ),
                    4.kW,
                    Text(
                      userReview.createdAt.toTimeAgo(),
                      style: CustomFonts.bodyExtraSmall
                          .copyWith(color: CustomColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        8.kH,
        Flexible(
          child: Text(
            userReview.reviewContent,
            style: CustomFonts.bodySmall,
          ),
        )
      ],
    );
  }
}
