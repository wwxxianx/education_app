import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:equatable/equatable.dart';

final class SearchCourseState extends Equatable {
  final ApiResult<List<Course>> coursesResult;
  // final List<String> selectedCategoryIds;
  final List<CourseCategory> selectedCategories;
  final List<String> selectedSubcategoryIds;
  final List<String> selectedLevelIds;
  final List<String> selectedLanguageIds;
  final String? searchQuery;

  int get filterLength {
    return selectedCategories.length +
        selectedSubcategoryIds.length +
        selectedLanguageIds.length +
        selectedLevelIds.length;
  }

  const SearchCourseState._({
    required this.coursesResult,
    this.selectedCategories = const [],
    this.searchQuery,
    this.selectedLevelIds = const [],
    this.selectedLanguageIds = const [],
    this.selectedSubcategoryIds = const [],
  });

  const SearchCourseState.initial()
      : this._(
          coursesResult: const ApiResultLoading(),
        );

  SearchCourseState copyWith({
    bool? isGridView,
    ApiResult<List<Course>>? coursesResult,
    List<String>? selectedStateIds,
    List<CourseCategory>? selectedCategories,
    String? searchQuery,
    List<String>? selectedLevelIds,
    List<String>? selectedLanguageIds,
    List<String>? selectedSubcategoryIds,
  }) {
    return SearchCourseState._(
      coursesResult: coursesResult ?? this.coursesResult,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedLevelIds: selectedLevelIds ?? this.selectedLevelIds,
      selectedLanguageIds: selectedLanguageIds ?? this.selectedLanguageIds,
      selectedSubcategoryIds: selectedSubcategoryIds ?? this.selectedSubcategoryIds,
    );
  }

  @override
  List<Object?> get props => [
        coursesResult,
        selectedCategories,
        searchQuery,
        selectedLevelIds,
        selectedLanguageIds,
        selectedSubcategoryIds,
      ];
}
