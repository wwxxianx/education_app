import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class ManageCourseDetailsState extends Equatable {
  final int currentTabIndex;
  final ApiResult<Course> courseResult;

  const ManageCourseDetailsState._({
    this.currentTabIndex = 0,
    this.courseResult = const ApiResultLoading(),
  });

  const ManageCourseDetailsState.initial() : this._(currentTabIndex: 0);

  const ManageCourseDetailsState.fetchCourseInProgress()
      : this._(
          courseResult: const ApiResultLoading(),
        );

  ManageCourseDetailsState.fetchCourseSuccess(Course data)
      : this._(
          courseResult: ApiResultSuccess(data),
        );

  ManageCourseDetailsState.fetchCourseFailed(String? errorMessage)
      : this._(
          courseResult: ApiResultFailure(errorMessage),
        );

  ManageCourseDetailsState copyWith({
    int? currentTabIndex,
    ApiResult<Course>? courseResult,
  }) {
    return ManageCourseDetailsState._(
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
