import 'package:flutter/material.dart';

@immutable
sealed class ExploreEvent {
  const ExploreEvent();
}

final class OnFetchPopularCourses extends ExploreEvent {}

final class OnFetchPurchaseRecommendedCourse extends ExploreEvent {}

final class OnFetchPreferenceRecommendedCourse extends ExploreEvent {}
final class OnRefreshData extends ExploreEvent {}