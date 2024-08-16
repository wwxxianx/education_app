import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/state_management/my_course/my_course_event.dart';
import 'package:education_app/state_management/my_course/my_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCourseBloc extends Bloc<MyCourseEvent, MyCourseState> {
  final FetchCourses _fetchCourses;
  MyCourseBloc({
    required FetchCourses fetchCourses,
  })  : _fetchCourses = fetchCourses,
        super(const MyCourseState.initial()) {
    on<MyCourseEvent>(_onEvent);
  }

  Future<void> _onEvent(
      MyCourseEvent event, Emitter<MyCourseState> emit) async {
    return switch (event) {
      final OnFetchMyCourses e => _onFetchMyCourses(e, emit),
    };
  }

  Future<void> _onFetchMyCourses(
      OnFetchMyCourses event, Emitter<MyCourseState> emit) async {
    emit(state.copyWith(myCoursesResult: const ApiResultLoading()));
    final filters = CourseFilters(
      instructorId: event.currentUserId,
    );
    final res = await _fetchCourses.call(filters);
    res.fold(
      (failure) => emit(state.copyWith(
          myCoursesResult: ApiResultFailure(failure.errorMessage))),
      (courses) {
        emit(state.copyWith(myCoursesResult: ApiResultSuccess(courses)));
      },
    );
  }
}
