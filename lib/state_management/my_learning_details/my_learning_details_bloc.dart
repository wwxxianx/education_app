import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/course_progress_payload.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/domain/usecases/user/update_recent_course_progress.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_event.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLearningDetailsBloc
    extends Bloc<MyLearningDetailsEvent, MyLearningDetailsState> {
  final FetchCourse _fetchCourse;
  final UpdateRecentCourseProgress _updateRecentCourseProgress;
  MyLearningDetailsBloc({
    required FetchCourse fetchCourse,
    required UpdateRecentCourseProgress updateRecentCourseProgress,
  })  : _fetchCourse = fetchCourse,
        _updateRecentCourseProgress = updateRecentCourseProgress,
        super(const MyLearningDetailsState.initial()) {
    on<MyLearningDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(MyLearningDetailsEvent event,
      Emitter<MyLearningDetailsState> emit) async {
    return switch (event) {
      final OnFetchCourse e => _onFetchCourse(e, emit),
      final OnCurrentPartChanged e => _onCurrentPartChanged(e, emit),
      final OnInitFocusCoursePartFromProgress e =>
        _onInitFocusCoursePartFromProgress(e, emit),
    };
  }

  void _onInitFocusCoursePartFromProgress(
    OnInitFocusCoursePartFromProgress event,
    Emitter<MyLearningDetailsState> emit,
  ) {
    if (event.coursePart != null) {
      emit(state.copyWith(currentPart: event.coursePart));
    }
  }

  Future<void> _onFetchCourse(
    OnFetchCourse event,
    Emitter<MyLearningDetailsState> emit,
  ) async {
    emit(state.copyWith(courseResult: const ApiResultLoading()));
    final res = await _fetchCourse.call(event.courseId);
    res.fold(
      (failure) => emit(
          state.copyWith(courseResult: ApiResultFailure(failure.errorMessage))),
      (course) {
        emit(state.copyWith(
          courseResult: ApiResultSuccess(course),
          currentPart: course.sections.first.parts.first,
        ));
        if (event.progressCoursePart != null) {
          emit(state.copyWith(currentPart: event.progressCoursePart));
        }
      },
    );
  }

  Future<void> _onCurrentPartChanged(
    OnCurrentPartChanged event,
    Emitter<MyLearningDetailsState> emit,
  ) async {
    emit(state.copyWith(currentPart: event.part));
    // Save to user's recent course progress
    final payload =
        CourseProgressPayload(partId: event.part.id, courseId: event.courseId);
    final res = await _updateRecentCourseProgress.call(payload);
    res.fold(
      (failure) => null,
      (data) {
        event.onSuccess(data);
      },
    );
  }
}
