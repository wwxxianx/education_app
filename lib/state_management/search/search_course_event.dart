import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:flutter/material.dart';

@immutable
sealed class SearchCourseEvent {
  const SearchCourseEvent();
}

final class OnFetchCourses extends SearchCourseEvent {}

final class OnSelectCourseCategory extends SearchCourseEvent {
  final CourseCategory category;

  const OnSelectCourseCategory({required this.category});
}

final class OnSearchQueryChanged extends SearchCourseEvent {
  final String searchQuery;

  const OnSearchQueryChanged({required this.searchQuery});
}

final class OnSelectCourseLevel extends SearchCourseEvent {
  final String levelId;

  const OnSelectCourseLevel({required this.levelId});
}

final class OnSelectCourseLanguage extends SearchCourseEvent {
  final String languageId;

  const OnSelectCourseLanguage({required this.languageId});
}

final class OnSelectSubcategory extends SearchCourseEvent {
  final String subcategoryId;

  const OnSelectSubcategory({required this.subcategoryId});
}