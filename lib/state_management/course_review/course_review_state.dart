import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:equatable/equatable.dart';

final class CourseReviewState extends Equatable {
  final ApiResult<List<UserReview>> courseReviewResult;
  final ApiResult<UserReview> submitReviewResult;

  const CourseReviewState({
    this.courseReviewResult = const ApiResultInitial(),
    this.submitReviewResult = const ApiResultInitial(),
  });

  const CourseReviewState.initial() : this();

  CourseReviewState copyWith({
    ApiResult<List<UserReview>>? courseReviewResult,
    ApiResult<UserReview>? submitReviewResult,
  }) {
    return CourseReviewState(
      courseReviewResult: courseReviewResult ?? this.courseReviewResult,
      submitReviewResult: submitReviewResult ?? this.submitReviewResult,
    );
  }

  @override
  List<Object?> get props => [courseReviewResult, submitReviewResult];
}
