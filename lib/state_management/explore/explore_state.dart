import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/response/course/recommended_course.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class ExploreState extends Equatable {
  final ApiResult<List<Course>> popularCoursesResult;
  final ApiResult<RecommendedCourseFromPurchaseHistory> recommendedCourseFromPurchaseHistory;
  final ApiResult<List<Course>> recommendedCourseFromPreference;
  const ExploreState({
    this.popularCoursesResult = const ApiResultInitial(),
    this.recommendedCourseFromPurchaseHistory = const ApiResultInitial(),
    this.recommendedCourseFromPreference = const ApiResultInitial(),
  });

  const ExploreState.initial() : this();

  ExploreState copyWith({
    ApiResult<List<Course>>? popularCoursesResult,
    ApiResult<RecommendedCourseFromPurchaseHistory>? recommendedCourseFromPurchaseHistory,
    ApiResult<List<Course>>? recommendedCourseFromPreference,
  }) {
    return ExploreState(
      popularCoursesResult: popularCoursesResult ?? this.popularCoursesResult,
      recommendedCourseFromPurchaseHistory:
          recommendedCourseFromPurchaseHistory ??
              this.recommendedCourseFromPurchaseHistory,
      recommendedCourseFromPreference: recommendedCourseFromPreference ??
          this.recommendedCourseFromPreference,
    );
  }

  @override
  List<Object?> get props => [
        popularCoursesResult,
        recommendedCourseFromPurchaseHistory,
        recommendedCourseFromPreference,
      ];
}
