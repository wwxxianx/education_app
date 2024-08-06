import 'package:flutter/material.dart';

@immutable
sealed class MyCourseEvent {
  const MyCourseEvent();
}

final class OnFetchMyCourses extends MyCourseEvent {
  final String currentUserId;
  final VoidCallback? onSuccess;

  const OnFetchMyCourses({required this.currentUserId, this.onSuccess});
}
