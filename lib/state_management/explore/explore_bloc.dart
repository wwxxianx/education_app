import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/domain/usecases/user/fetch_preference_recommended_course%20copy.dart';
import 'package:education_app/domain/usecases/user/fetch_purchase_recommended_course.dart';
import 'package:education_app/state_management/explore/explore_event.dart';
import 'package:education_app/state_management/explore/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final FetchCourses _fetchCourses;
  final FetchPurchaseRecommendedCourse _fetchPurchaseRecommendedCourse;
  final FetchPreferenceRecommendedCourse _fetchPreferenceRecommendedCourse;
  ExploreBloc({
    required FetchCourses fetchCourses,
    required FetchPurchaseRecommendedCourse fetchPurchaseRecommendedCourse,
    required FetchPreferenceRecommendedCourse fetchPreferenceRecommendedCourse,
  })  : _fetchCourses = fetchCourses,
        _fetchPurchaseRecommendedCourse = fetchPurchaseRecommendedCourse,
        _fetchPreferenceRecommendedCourse = fetchPreferenceRecommendedCourse,
        super(const ExploreState.initial()) {
    on<ExploreEvent>(_onEvent);
  }

  Future<void> _onEvent(ExploreEvent event, Emitter<ExploreState> emit) async {
    return switch (event) {
      final OnFetchPopularCourses e => _onFetchPopularCourses(e, emit),
      final OnFetchPurchaseRecommendedCourse e =>
        _onFetchPurchaseRecommendedCourse(e, emit),
      final OnFetchPreferenceRecommendedCourse e =>
        _onFetchPreferenceRecommendedCourse(e, emit),
      final OnRefreshData e => _onRefreshData(e, emit),
    };
  }

  Future<void> _onRefreshData(
    OnRefreshData event,
    Emitter<ExploreState> emit,
  ) async {
    final prefRes = await _fetchPreferenceRecommendedCourse.call(NoPayload());
    final purRes = await _fetchPurchaseRecommendedCourse.call(NoPayload());
    prefRes.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(
            recommendedCourseFromPreference: ApiResultSuccess(r)));
      },
    );
    purRes.fold(
      (l) => null,
      (r) {
        emit(state.copyWith(
            recommendedCourseFromPurchaseHistory: ApiResultSuccess(r)));
      },
    );
  }

  Future<void> _onFetchPurchaseRecommendedCourse(
    OnFetchPurchaseRecommendedCourse event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(
        recommendedCourseFromPurchaseHistory: const ApiResultLoading()));
    final res = await _fetchPurchaseRecommendedCourse.call(NoPayload());
    res.fold(
      (l) => null,
      (data) {
        emit(state.copyWith(
            recommendedCourseFromPurchaseHistory: ApiResultSuccess(data)));
      },
    );
  }

  Future<void> _onFetchPreferenceRecommendedCourse(
    OnFetchPreferenceRecommendedCourse event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(
        recommendedCourseFromPreference: const ApiResultLoading()));
    final res = await _fetchPreferenceRecommendedCourse.call(NoPayload());
    res.fold(
      (l) => null,
      (data) {
        emit(state.copyWith(
            recommendedCourseFromPreference: ApiResultSuccess(data)));
      },
    );
  }

  Future<void> _onFetchPopularCourses(
    OnFetchPopularCourses event,
    Emitter<ExploreState> emit,
  ) async {
    final popularCoursesResult = state.popularCoursesResult;
    if (popularCoursesResult is ApiResultSuccess<List<Course>>) {
      return;
    }
    emit(state.copyWith(popularCoursesResult: const ApiResultLoading()));

    final filters = CourseFilters(
      status: CoursePublishStatus.PUBLISHED,
    );
    final res = await _fetchCourses.call(filters);
    res.fold(
      (l) => null,
      (data) {
        emit(state.copyWith(popularCoursesResult: ApiResultSuccess(data)));
      },
    );
  }
}
