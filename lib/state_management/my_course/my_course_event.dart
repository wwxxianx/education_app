import 'package:flutter/material.dart';

@immutable
sealed class MyCourseEvent {
  const MyCourseEvent();
}

final class OnFetchMyCourses extends MyCourseEvent {
  final VoidCallback? onSuccess;

  const OnFetchMyCourses({this.onSuccess});
}