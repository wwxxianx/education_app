import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class CourseDetailsState extends Equatable {
  final int currentTabIndex;
  final ApiResult<Course> courseResult;

  const CourseDetailsState._({
    this.currentTabIndex = 0,
    this.courseResult = const ApiResultLoading(),
  });

  const CourseDetailsState.initial() : this._(currentTabIndex: 0);

  const CourseDetailsState.fetchCourseInProgress()
      : this._(
          courseResult: const ApiResultLoading(),
        );

  CourseDetailsState.fetchCourseSuccess(Course data)
      : this._(
          courseResult: ApiResultSuccess(data),
        );

  CourseDetailsState.fetchCourseFailed(String? errorMessage)
      : this._(
          courseResult: ApiResultFailure(errorMessage),
        );

  CourseDetailsState copyWith({
    int? currentTabIndex,
    ApiResult<Course>? courseResult,
  }) {
    return CourseDetailsState._(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      courseResult: courseResult ?? this.courseResult,
    );
  }

  @override
  List<Object?> get props => [
        currentTabIndex,
        courseResult,
      ];
}
