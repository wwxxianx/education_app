import 'package:flutter/material.dart';

@immutable
sealed class ExploreEvent {
  const ExploreEvent();
}

final class OnFetchPopularCourses extends ExploreEvent {}
