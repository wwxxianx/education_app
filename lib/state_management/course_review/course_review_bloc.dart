import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/user_review.dart';
import 'package:education_app/domain/usecases/course/create_course_review.dart';
import 'package:education_app/domain/usecases/course/fetch_course_reviews.dart';
import 'package:education_app/state_management/course_review/course_review_event.dart';
import 'package:education_app/state_management/course_review/course_review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseReviewBloc extends Bloc<CourseReviewEvent, CourseReviewState> {
  final CreateCourseReview _createCourseReview;
  final FetchCourseReviews _fetchCourseReviews;

  CourseReviewBloc({
    required CreateCourseReview createCourseReview,
    required FetchCourseReviews fetchCourseReviews,
  })  : _createCourseReview = createCourseReview,
        _fetchCourseReviews = fetchCourseReviews,
        super(const CourseReviewState.initial()) {
    on<CourseReviewEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CourseReviewEvent event,
    Emitter<CourseReviewState> emit,
  ) async {
    return switch (event) {
      final OnFetchCourseReview e => _onFetchCourseReview(e, emit),
      final OnSubmitReview e => _onSubmitReview(e, emit),
    };
  }

  Future<void> _onSubmitReview(
    OnSubmitReview event,
    Emitter emit,
  ) async {
    emit(state.copyWith(submitReviewResult: const ApiResultLoading()));
    final res = await _createCourseReview.call(event.payload);
    res.fold(
      (failure) => emit(
          state.copyWith(submitReviewResult: ApiResultFailure(failure.errorMessage))),
      (review) {
        _updateToLatestData(review, emit);
        emit(state.copyWith(submitReviewResult: ApiResultSuccess(review)));
        event.onSuccess.call(review);
      },
    );
  }

  Future<void> _onFetchCourseReview(
    OnFetchCourseReview event,
    Emitter emit,
  ) async {
    emit(state.copyWith(courseReviewResult: const ApiResultLoading()));
    final res = await _fetchCourseReviews.call(event.courseId);
    res.fold(
      (failure) => emit(
          state.copyWith(courseReviewResult: ApiResultFailure(failure.errorMessage))),
      (reviews) => emit(state.copyWith(courseReviewResult: ApiResultSuccess(reviews))),
    );
  }

  _updateToLatestData(
    UserReview data,
    Emitter emit,
  ) {
    final courseReviewResult = state.courseReviewResult;

    if (courseReviewResult is ApiResultSuccess<List<UserReview>>) {
      emit(state.copyWith(
          courseReviewResult:
              ApiResultSuccess([data, ...courseReviewResult.data])));
    }
  }
}
