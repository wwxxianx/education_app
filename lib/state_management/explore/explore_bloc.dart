import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/state_management/explore/explore_event.dart';
import 'package:education_app/state_management/explore/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final FetchCourses _fetchCourses;
  ExploreBloc({
    required FetchCourses fetchCourses,
  })  : _fetchCourses = fetchCourses,
        super(const ExploreState.initial()) {
    on<ExploreEvent>(_onEvent);
  }

  Future<void> _onEvent(ExploreEvent event, Emitter<ExploreState> emit) async {
    return switch (event) {
      final OnFetchPopularCourses e => _onFetchPopularCourses(e, emit),
    };
  }

  Future<void> _onFetchPopularCourses(
    OnFetchPopularCourses event,
    Emitter<ExploreState> emit,
  ) async {
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
