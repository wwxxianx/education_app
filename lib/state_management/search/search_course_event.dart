import 'package:flutter/material.dart';

@immutable
sealed class SearchCourseEvent {
  const SearchCourseEvent();
}

final class OnFetchCourses extends SearchCourseEvent {}

final class OnSelectCourseCategory extends SearchCourseEvent {
  final String categoryId;

  const OnSelectCourseCategory({required this.categoryId});
}

final class OnSearchQueryChanged extends SearchCourseEvent {
  final String searchQuery;

  const OnSearchQueryChanged({required this.searchQuery});
}
