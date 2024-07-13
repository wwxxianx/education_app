import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/state_management/course_details/course_details_event.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsBloc extends Bloc<CourseDetailsEvent, CourseDetailsState> {
  final FetchCourse _fetchCourse;

  CourseDetailsBloc({
    required FetchCourse fetchCourse,
  })  : _fetchCourse = fetchCourse,
        super(const CourseDetailsState.initial()) {
    on<CourseDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    CourseDetailsEvent event,
    Emitter<CourseDetailsState> emit,
  ) async {
    return switch (event) {
      final OnTabIndexChanged e => _onTabIndexChanged(e, emit),
      final OnFetchCourse e => _onFetchCourse(e, emit),
    };
  }

  Future<void> _onFetchCourse(
    OnFetchCourse event,
    Emitter emit,
  ) async {
    final res = await _fetchCourse.call(event.courseId);
    res.fold(
      (failure) => emit(CourseDetailsState.fetchCourseFailed(failure.errorMessage)),
      (course) => emit(CourseDetailsState.fetchCourseSuccess(course)),
    );
  }

  void _onTabIndexChanged(
    OnTabIndexChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.index));
  }
}
