import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/user/fetch_learning_courses.dart';
import 'package:education_app/state_management/my_learning/my_learning_event.dart';
import 'package:education_app/state_management/my_learning/my_learning_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLearningBloc extends Bloc<MyLearningEvent, MyLearningState> {
  final FetchLearningCourses _fetchLearningCourses;

  MyLearningBloc({
    required FetchLearningCourses fetchLearningCourses,
  })  : _fetchLearningCourses = fetchLearningCourses,
        super(const MyLearningState.initial()) {
    on<MyLearningEvent>(_onEvent);
  }

  Future<void> _onEvent(
      MyLearningEvent event, Emitter<MyLearningState> emit) async {
    return switch (event) {
      final OnFetchMyLearningCourses e => _onFetchMyLearningCourses(e, emit),
    };
  }

  Future<void> _onFetchMyLearningCourses(
      OnFetchMyLearningCourses event, Emitter<MyLearningState> emit) async {
    emit(state.copyWith(coursesResult: const ApiResultInitial()));
    final res = await _fetchLearningCourses.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          coursesResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(state.copyWith(coursesResult: ApiResultSuccess(data ?? []))),
    );
  }
}
