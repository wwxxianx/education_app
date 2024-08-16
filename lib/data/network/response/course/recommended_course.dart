import 'package:education_app/domain/model/course/course.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommended_course.g.dart';

@JsonSerializable()
class RecommendedCourse {
  final List<Course> recommendedCourses;

  const RecommendedCourse({
    this.recommendedCourses = const [],
  });

  factory RecommendedCourse.fromJson(Map<String, dynamic> json) =>
      _$RecommendedCourseFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedCourseToJson(this);
}

@JsonSerializable()
class RecommendedCourseFromPurchaseHistory extends RecommendedCourse {
  final CourseSummary? latestPurchase;

  const RecommendedCourseFromPurchaseHistory({
    super.recommendedCourses,
    this.latestPurchase,
  });

  factory RecommendedCourseFromPurchaseHistory.fromJson(
          Map<String, dynamic> json) =>
      _$RecommendedCourseFromPurchaseHistoryFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RecommendedCourseFromPurchaseHistoryToJson(this);
}
