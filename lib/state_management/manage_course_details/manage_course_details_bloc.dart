

import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCourseDetailsBloc extends Bloc<ManageCourseDetailsEvent, ManageCourseDetailsState> {
  final FetchCourse _fetchCourse;

  ManageCourseDetailsBloc({
    required FetchCourse fetchCourse,
  })  : _fetchCourse = fetchCourse,
        super(const ManageCourseDetailsState.initial()) {
    on<ManageCourseDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ManageCourseDetailsEvent event,
    Emitter<ManageCourseDetailsState> emit,
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
      (failure) => emit(ManageCourseDetailsState.fetchCourseFailed(failure.errorMessage)),
      (course) => emit(ManageCourseDetailsState.fetchCourseSuccess(course)),
    );
  }

  void _onTabIndexChanged(
    OnTabIndexChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.index));
  }
}
