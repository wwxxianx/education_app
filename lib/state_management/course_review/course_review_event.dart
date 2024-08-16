import 'package:education_app/data/network/payload/course/course_review_payload.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CourseReviewEvent {
  const CourseReviewEvent();
}

final class OnFetchCourseReview extends CourseReviewEvent {
  final String courseId;
  const OnFetchCourseReview({required this.courseId});
}

final class OnSubmitReview extends CourseReviewEvent {
  final CourseReviewPayload payload;
  final void Function(UserReview data) onSuccess;

  const OnSubmitReview({required this.payload, required this.onSuccess});
}
