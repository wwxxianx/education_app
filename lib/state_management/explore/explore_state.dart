import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class ExploreState extends Equatable {
  final ApiResult<List<Course>> popularCoursesResult;

  const ExploreState({
    this.popularCoursesResult = const ApiResultInitial(),
  });

  const ExploreState.initial() : this();

  ExploreState copyWith({
    ApiResult<List<Course>>? popularCoursesResult,
  }) {
    return ExploreState(
      popularCoursesResult: popularCoursesResult ?? this.popularCoursesResult,
    );
  }

  @override
  List<Object?> get props => [popularCoursesResult];
}
