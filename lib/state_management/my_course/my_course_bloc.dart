import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/state_management/my_course/my_course_event.dart';
import 'package:education_app/state_management/my_course/my_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCourseBloc extends Bloc<MyCourseEvent, MyCourseState> {
  MyCourseBloc() : super(const MyCourseState.initial()) {
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
    emit(state.copyWith(myCoursesResult: ApiResultSuccess(Course.samples)));
    // emit(state.copyWith(myCoursesResult: await event.onSuccess()));
  }
}
