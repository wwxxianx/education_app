import 'dart:io';

import 'package:education_app/common/utils/input_validator.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

class CoursePartField {
  final String? title;
  final File? resourceFile;

  const CoursePartField({this.title, this.resourceFile});

  CoursePartField copyWith({
    String? title,
    File? resourceFile,
  }) {
    return CoursePartField(
      title: title ?? this.title,
      resourceFile: resourceFile,
    );
  }
}

final class CreateCourseState extends Equatable with InputValidator {
  // Fetch data

  // Relations
  final String? selectedCategoryId;
  final List<String> selectedSubcategoryIds;
  final String? categoryError;
  final String? subcategoryError;

  // Details
  final String? titleText;
  final String? descriptionText;
  final String? selectedLanguageId;
  final String? titleError;
  final String? descriptionError;
  final String? languageError;
  final String? selectedLevelId;
  final String? levelError;

  // Media
  final List<File> courseImageFiles;
  final File? courseVideoFile;
  final String? imageError;

  // Overview
  final List<String> topics;
  final List<String> requirements;

  // Curriculum
  final String? sectionOneTitle;
  final List<CoursePartField> partFields;

  // Price
  final String? priceText;

  // Create campaign
  final ApiResult<Course> createCourseResult;

  const CreateCourseState._({
    this.selectedCategoryId,
    this.selectedSubcategoryIds = const [],
    this.categoryError,
    this.subcategoryError,
    this.titleText,
    this.descriptionText,
    this.selectedLanguageId,
    this.titleError,
    this.descriptionError,
    this.languageError,
    this.topics = const ['', ''],
    this.requirements = const ['', ''],
    this.priceText = '',
    this.partFields = const [CoursePartField()],
    this.createCourseResult = const ApiResultInitial(),
    this.sectionOneTitle,
    this.selectedLevelId,
    this.levelError,
    this.courseImageFiles = const [],
    this.courseVideoFile,
    this.imageError,
  });

  const CreateCourseState.initial() : this._();

  CreateCourseState copyWith({
    String? selectedCategoryId,
    List<String>? selectedSubcategoryIds,
    String? categoryError,
    String? subcategoryError,
    String? titleText,
    String? descriptionText,
    String? selectedLanguageId,
    String? titleError,
    String? descriptionError,
    String? languageError,
    List<String>? topics,
    List<String>? requirements,
    String? priceText,
    List<CoursePartField>? partFields,
    ApiResult<Course>? createCourseResult,
    String? sectionOneTitle,
    String? selectedLevelId,
    String? levelError,
    List<File>? courseImageFiles,
    File? courseVideoFile,
    String? imageError,
  }) {
    return CreateCourseState._(
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSubcategoryIds:
          selectedSubcategoryIds ?? this.selectedSubcategoryIds,
      categoryError: categoryError ?? this.categoryError,
      subcategoryError: subcategoryError,
      titleText: titleText ?? this.titleText,
      descriptionText: descriptionText ?? this.descriptionText,
      selectedLanguageId: selectedLanguageId ?? this.selectedLanguageId,
      titleError: titleError,
      descriptionError: descriptionError,
      languageError: languageError,
      topics: topics ?? this.topics,
      requirements: requirements ?? this.requirements,
      priceText: priceText ?? this.priceText,
      partFields: partFields ?? this.partFields,
      createCourseResult: createCourseResult ?? this.createCourseResult,
      sectionOneTitle: sectionOneTitle ?? this.sectionOneTitle,
      selectedLevelId: selectedLevelId ?? this.selectedLevelId,
      levelError: levelError,
      courseImageFiles: courseImageFiles ?? this.courseImageFiles,
      courseVideoFile: courseVideoFile ?? this.courseVideoFile,
      imageError: imageError,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategoryId,
        selectedSubcategoryIds,
        categoryError,
        subcategoryError,
        titleText,
        descriptionText,
        selectedLanguageId,
        titleError,
        descriptionError,
        languageError,
        topics,
        requirements,
        priceText,
        partFields,
        createCourseResult,
        sectionOneTitle,
        selectedLevelId,
        levelError,
        courseImageFiles,
        courseVideoFile,
        imageError,
      ];
}
