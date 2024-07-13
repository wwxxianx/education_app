import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class MyCourseState extends Equatable {
  final ApiResult<List<Course>> myCoursesResult;

  const MyCourseState._({
    required this.myCoursesResult,
  });

  const MyCourseState.initial()
      : this._(myCoursesResult: const ApiResultInitial());

  MyCourseState copyWith({
    ApiResult<List<Course>>? myCoursesResult,
  }) {
    return MyCourseState._(
      myCoursesResult: myCoursesResult ?? this.myCoursesResult,
    );
  }

  @override
  List<Object?> get props => [myCoursesResult];
}
