import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_event.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLearningDetailsBloc
    extends Bloc<MyLearningDetailsEvent, MyLearningDetailsState> {
  final FetchCourse _fetchCourse;
  MyLearningDetailsBloc({
    required FetchCourse fetchCourse,
  })  : _fetchCourse = fetchCourse,
        super(const MyLearningDetailsState.initial()) {
    on<MyLearningDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(MyLearningDetailsEvent event,
      Emitter<MyLearningDetailsState> emit) async {
    return switch (event) {
      final OnFetchCourse e => _onFetchCourse(e, emit),
      final OnCurrentPartChanged e => _onCurrentPartChanged(e, emit),
    };
  }

  Future<void> _onFetchCourse(
      OnFetchCourse event, Emitter<MyLearningDetailsState> emit) async {
    emit(state.copyWith(courseResult: const ApiResultLoading()));
    final res = await _fetchCourse.call(event.courseId);
    res.fold(
      (failure) => emit(state.copyWith(courseResult: ApiResultFailure(failure.errorMessage))),
      (course) {
        emit(state.copyWith(
          courseResult: ApiResultSuccess(course),
          currentPart: course.sections.first.parts.first,
        ));
      },
    );
  }

  void _onCurrentPartChanged(
      OnCurrentPartChanged event, Emitter<MyLearningDetailsState> emit
  ) {
    emit(state.copyWith(currentPart: event.part));
  }
}
