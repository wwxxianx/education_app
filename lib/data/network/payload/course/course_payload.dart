import 'dart:io';

import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:equatable/equatable.dart';

class CreateCoursePayload extends Equatable {
  final String categoryId;
  final List<String> coursePartsTitle;
  final String description;
  final String levelId;
  final List<String> requirements;
  final String title;
  final List<String> topics;
  final List<String> subcategoryIds;
  final String languageId;
  final String sectionOneTitle;
  final double? price;
  final List<File> courseImages;
  final File? courseVideo;
  final List<File> courseResourceFiles;

  const CreateCoursePayload({
    required this.categoryId,
    required this.coursePartsTitle,
    required this.description,
    required this.levelId,
    required this.requirements,
    required this.title,
    required this.topics,
    required this.subcategoryIds,
    required this.languageId,
    required this.sectionOneTitle,
    this.price,
    required this.courseImages,
    this.courseVideo,
    required this.courseResourceFiles,
  });

  @override
  List<Object?> get props => [
        categoryId,
        coursePartsTitle,
        description,
        levelId,
        requirements,
        title,
        topics,
        subcategoryIds,
        languageId,
        sectionOneTitle,
        price,
        courseImages,
        courseVideo,
        courseResourceFiles
      ];

  @override
  bool get stringify => true;
}

class UpdateCoursePayload extends Equatable {
  final String courseId;
  final String? categoryId;
  final String? description;
  final String? levelId;
  final List<String>? requirements;
  final String? title;
  final List<String>? topics;
  final List<String>? subcategoryIds;
  final String? languageId;
  final double? price;
  final List<File>? courseImages;
  final File? courseVideo;
  final CoursePublishStatus? status;

  const UpdateCoursePayload({
    required this.courseId,
    this.categoryId,
    this.description,
    this.levelId,
    this.requirements,
    this.title,
    this.topics,
    this.subcategoryIds,
    this.languageId,
    this.price,
    this.courseImages,
    this.courseVideo,
    this.status,
  });

  @override
  List<Object?> get props => [
    courseId,
        categoryId,
        description,
        levelId,
        requirements,
        title,
        topics,
        subcategoryIds,
        languageId,
        price,
        courseImages,
        courseVideo,
      ];

  @override
  bool get stringify => true;
}
