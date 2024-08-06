import 'package:education_app/domain/model/course/enum/course_enum.dart';

class CourseFilters {
  final String? instructorId;
  final List<String> categoryIds;
  final List<String> subcategoryIds;
  final bool? isFree;
  final List<String> levelIds;
  final List<String> languageIds;
  final String? searchQuery;
  final CoursePublishStatus? status;

  const CourseFilters({
    this.instructorId,
    this.categoryIds = const [],
    this.isFree,
    this.levelIds = const [],
    this.languageIds = const [],
    this.subcategoryIds = const [],
    this.searchQuery,
    this.status,
  });
}
