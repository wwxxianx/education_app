import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:equatable/equatable.dart';

final class UserFavouriteCourseState extends Equatable {
  final ApiResult<List<UserFavouriteCourse>> favouriteCoursesResult;
  final ApiResult<UserFavouriteCourse> updateResult;

  const UserFavouriteCourseState({
    required this.favouriteCoursesResult,
    required this.updateResult,
  });

  const UserFavouriteCourseState.initial()
      : this(
          favouriteCoursesResult: const ApiResultInitial(),
          updateResult: const ApiResultInitial(),
        );

  UserFavouriteCourseState copyWith({
    ApiResult<List<UserFavouriteCourse>>? favouriteCoursesResult,
    ApiResult<UserFavouriteCourse>? updateResult,
  }) {
    return UserFavouriteCourseState(
      favouriteCoursesResult:
          favouriteCoursesResult ?? this.favouriteCoursesResult,
      updateResult: updateResult ?? this.updateResult,
    );
  }

  @override
  List<Object?> get props => [favouriteCoursesResult, updateResult];
}
