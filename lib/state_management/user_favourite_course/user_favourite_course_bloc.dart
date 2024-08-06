import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/favourite_course_payload.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/domain/usecases/user/fetch_favourite_courses.dart';
import 'package:education_app/domain/usecases/user/update_favourite_course.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_event.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class UserFavouriteCourseBloc
    extends Bloc<UserFavouriteCourseEvent, UserFavouriteCourseState> {
  final FetchFavouriteCourses _fetchFavouriteCourses;
  final UpdateFavouriteCourse _updateFavouriteCourse;
  UserFavouriteCourseBloc({
    required FetchFavouriteCourses fetchFavouriteCourses,
    required UpdateFavouriteCourse updateFavouriteCourse,
  })  : _fetchFavouriteCourses = fetchFavouriteCourses,
        _updateFavouriteCourse = updateFavouriteCourse,
        super(const UserFavouriteCourseState.initial()) {
    on<UserFavouriteCourseEvent>(_onEvent);
  }

  Future<void> _onEvent(UserFavouriteCourseEvent event,
      Emitter<UserFavouriteCourseState> emit) async {
    return switch (event) {
      final OnFetchUserFavouriteCourses e =>
        _onFetchUserFavouriteCourses(e, emit),
      final OnUpdateUserFavouriteCourse e =>
        _onUpdateUserFavouriteCourse(e, emit),
    };
  }

  Future<void> _onFetchUserFavouriteCourses(OnFetchUserFavouriteCourses e,
      Emitter<UserFavouriteCourseState> emit) async {
    emit(state.copyWith(favouriteCoursesResult: const ApiResultLoading()));

    final res = await _fetchFavouriteCourses.call(NoPayload());

    res.fold(
      (failure) => emit(state.copyWith(
          favouriteCoursesResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(
        state.copyWith(favouriteCoursesResult: ApiResultSuccess(data)),
      ),
    );
  }

  Future<void> _onUpdateUserFavouriteCourse(OnUpdateUserFavouriteCourse event,
      Emitter<UserFavouriteCourseState> emit) async {
    emit(state.copyWith(updateResult: const ApiResultLoading()));
    final payload = UserFavouriteCoursePayload(courseId: event.courseId);
    final res = await _updateFavouriteCourse.call(payload);

    res.fold(
        (failure) => emit(state.copyWith(
            updateResult: ApiResultFailure(failure.errorMessage))), (course) {
      // Update app state
      final favouriteCoursesResult = state.favouriteCoursesResult;
      if (favouriteCoursesResult
          is ApiResultSuccess<List<UserFavouriteCourse>>) {
        final isCourseExist = favouriteCoursesResult.data.any(
            (favouriteCourse) => favouriteCourse.courseId == course.courseId);
        if (isCourseExist) {
          emit(
            state.copyWith(
              favouriteCoursesResult: ApiResultSuccess(
                favouriteCoursesResult.data
                    .filter((t) => t.courseId != course.courseId)
                    .toList(),
              ),
              updateResult: const ApiResultInitial(),
            ),
          );
          return;
        }
        // New course added
        emit(state.copyWith(
          favouriteCoursesResult: ApiResultSuccess(
            [course, ...favouriteCoursesResult.data].toList(),
          ),
          updateResult: const ApiResultInitial(),
        ));
      }
    });
  }
}
