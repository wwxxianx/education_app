import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/empty_illustration.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/common/widgets/text/expandable_text.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_review_payload.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/state_management/course_review/course_review_bloc.dart';
import 'package:education_app/state_management/course_review/course_review_event.dart';
import 'package:education_app/state_management/course_review/course_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ReviewDialog extends StatefulWidget {
  final String courseId;
  const ReviewDialog({
    super.key,
    required this.courseId,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double rating = 3;
  late final TextEditingController reviewTextController;

  @override
  void initState() {
    super.initState();
    reviewTextController = TextEditingController();
  }

  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }

  void _handleSubmitReview() {
    context.read<CourseReviewBloc>().add(OnSubmitReview(
          payload: CourseReviewPayload(
            courseId: widget.courseId,
            reviewContent: reviewTextController.text,
            reviewRating: rating.toInt(),
          ),
          onSuccess: (data) {
            context.pop();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseReviewBloc, CourseReviewState>(
      listener: (context, state) {
        final submitReviewResult = state.submitReviewResult;
        if (submitReviewResult is ApiResultFailure<UserReview>) {
          toastification.show(
              type: ToastificationType.error,
              title: Text(
                  submitReviewResult.errorMessage ?? "Something went wrong"));
        }
      },
      builder: (context, state) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave your review.',
                  style: CustomFonts.titleMedium,
                ),
                12.kH,
                RatingBar.builder(
                  itemSize: 24,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  },
                ),
                8.kH,
                CustomOutlinedTextfield(
                  controller: reviewTextController,
                  label: 'How do you feel about this course?',
                  hintText: 'Write your review here',
                ),
                20.kH,
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      _handleSubmitReview();
                    },
                    child: state.submitReviewResult is ApiResultLoading
                        ? SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Submit review'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ReviewBottomSheet extends StatelessWidget {
  final String courseId;
  const ReviewBottomSheet({
    super.key,
    required this.courseId,
  });

  void _showReviewDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<CourseReviewBloc>(context),
          child: ReviewDialog(
            courseId: courseId,
          ),
        );
      },
    );
  }

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
          return CustomDraggableSheet(
            initialChildSize: 0.5,
            footer: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
              child: CustomButton(
                height: 40,
                onPressed: () {
                  _showReviewDialog(context);
                },
                child: Text("Leave a review"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Course Reviews",
                    style: CustomFonts.titleMedium,
                  ),
                  24.kH,
                  if (courseReviewResult is ApiResultLoading)
                    CircularProgressIndicator(),
                  if (courseReviewResult is ApiResultSuccess<List<UserReview>>)
                    CourseReviewList(
                      reviews: courseReviewResult.data,
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CourseReviewList extends StatelessWidget {
  final List<UserReview> reviews;
  const CourseReviewList({
    super.key,
    this.reviews = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: EmptyIllustration(title: "No review yet..."),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: CourseReviewItem(userReview: reviews[index]));
      },
    );
  }
}

class CourseReviewItem extends StatelessWidget {
  final UserReview userReview;
  const CourseReviewItem({
    super.key,
    required this.userReview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Avatar(
              imageUrl: userReview.user.profileImageUrl,
              placeholder: userReview.user.fullName[0],
              size: 36,
            ),
            6.kW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userReview.user.fullName,
                  style: CustomFonts.bodySmall,
                ),
                2.kH,
                Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 16,
                      initialRating: userReview.reviewRating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    4.kW,
                    Text(
                      userReview.createdAt.toTimeAgo(),
                      style: CustomFonts.bodyExtraSmall.copyWith(
                        color: CustomColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        6.kH,
        ExpandableText(
          text: userReview.reviewContent,
          maxLines: 5,
        )
      ],
    );
  }
}
