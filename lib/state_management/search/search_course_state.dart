import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:equatable/equatable.dart';

final class SearchCourseState extends Equatable {
  final ApiResult<List<Course>> coursesResult;
  final List<String> selectedCategoryIds;
  final String? searchQuery;

  const SearchCourseState._({
    required this.coursesResult,
    this.selectedCategoryIds = const [],
    this.searchQuery,
  });

  const SearchCourseState.initial()
      : this._(
          coursesResult: const ApiResultLoading(),
        );

  SearchCourseState copyWith({
    bool? isGridView,
    ApiResult<List<Course>>? coursesResult,
    List<String>? selectedStateIds,
    List<String>? selectedCategoryIds,
    String? searchQuery,
  }) {
    return SearchCourseState._(
      coursesResult: coursesResult ?? this.coursesResult,
      selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        coursesResult,
        selectedCategoryIds,
        searchQuery,
      ];
}
