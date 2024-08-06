// Create event

import 'package:flutter/material.dart';

@immutable
sealed class UserFavouriteCourseEvent {
  const UserFavouriteCourseEvent();
}

final class OnFetchUserFavouriteCourses extends UserFavouriteCourseEvent {}

final class OnUpdateUserFavouriteCourse extends UserFavouriteCourseEvent {
  final String courseId;  

  OnUpdateUserFavouriteCourse({required this.courseId});
}