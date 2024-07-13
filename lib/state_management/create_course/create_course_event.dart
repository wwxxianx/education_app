import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
sealed class CreateCourseEvent extends Equatable {
  const CreateCourseEvent();

  @override
  List<Object> get props => [];
}

final class OnSelectCourseCategory extends CreateCourseEvent {
  final String categoryId;

  const OnSelectCourseCategory({required this.categoryId});
}

final class OnSelectCourseSubcategory extends CreateCourseEvent {
  final String categoryId;

  const OnSelectCourseSubcategory({required this.categoryId});
}

final class OnAddCourseImageFile extends CreateCourseEvent {
  final List<File> files;

  const OnAddCourseImageFile({required this.files});
}

final class OnAddCourseVideoFile extends CreateCourseEvent {
  final File file;

  const OnAddCourseVideoFile({required this.file});
}

final class OnSelectLevel extends CreateCourseEvent {
  final String levelId;

  const OnSelectLevel({required this.levelId});
}

final class OnSectionTitleChanged extends CreateCourseEvent {
  final String value;

  const OnSectionTitleChanged({required this.value});
}

final class OnTitleChanged extends CreateCourseEvent {
  final String value;

  const OnTitleChanged({required this.value});
}

final class OnDescriptionChanged extends CreateCourseEvent {
  final String value;

  const OnDescriptionChanged({required this.value});
}

final class OnSyncTopics extends CreateCourseEvent {
  final List<String> topics;

  const OnSyncTopics({required this.topics});
}

final class OnSyncRequirements extends CreateCourseEvent {
  final List<String> requirements;

  const OnSyncRequirements({required this.requirements});
}

final class OnAddTopic extends CreateCourseEvent {}

final class OnRemoveTopic extends CreateCourseEvent {
  final int index;

  const OnRemoveTopic({required this.index});
}

final class OnReorderTopic extends CreateCourseEvent {
  final int oldIndex;
  final int newIndex;

  const OnReorderTopic({
    required this.oldIndex,
    required this.newIndex,
  });
}

final class OnSelectLanguage extends CreateCourseEvent {
  final String languageId;

  const OnSelectLanguage({required this.languageId});
}

final class OnPriceChanged extends CreateCourseEvent {
  final String value;

  const OnPriceChanged({required this.value});
}

final class ValidateRelationData extends CreateCourseEvent {
  final VoidCallback onSuccess;

  const ValidateRelationData({required this.onSuccess});
}

final class ValidateDetailData extends CreateCourseEvent {
  final VoidCallback onSuccess;

  const ValidateDetailData({required this.onSuccess});
}

final class ValidateMediaData extends CreateCourseEvent {
  final VoidCallback onSuccess;

  const ValidateMediaData({required this.onSuccess});
}

final class ValidateOverviewData extends CreateCourseEvent {
  final VoidCallback onSuccess;

  const ValidateOverviewData({required this.onSuccess});
}

final class ValidateCurriculumData extends CreateCourseEvent {
  final VoidCallback onSuccess;

  const ValidateCurriculumData({required this.onSuccess});
}

final class OnAddNewPart extends CreateCourseEvent {}

final class OnRemovePart extends CreateCourseEvent {
  final int index;

  const OnRemovePart({required this.index});
}

final class OnPartTitleChanged extends CreateCourseEvent {
  final int index;
  final String title;

  const OnPartTitleChanged({required this.index, required this.title});
}

final class OnPartFileChanged extends CreateCourseEvent {
  final int index;
  final File? file;

  const OnPartFileChanged({required this.index, required this.file});
}

final class OnCreateCourse extends CreateCourseEvent {
  final VoidCallback onSuccess;

  const OnCreateCourse({required this.onSuccess});
}
