import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_filters.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/state_management/search/search_course_event.dart';
import 'package:education_app/state_management/search/search_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCourseBloc extends Bloc<SearchCourseEvent, SearchCourseState> {
  final FetchCourses _fetchCourses;
  SearchCourseBloc({
    required FetchCourses fetchCourses,
  })  : _fetchCourses = fetchCourses,
        super(const SearchCourseState.initial()) {
    on<SearchCourseEvent>(_onEvent);
  }

  Future<void> _onEvent(
    SearchCourseEvent event,
    Emitter<SearchCourseState> emit,
  ) async {
    return switch (event) {
      final OnFetchCourses e => _onFetchCourses(e, emit),
      final OnSelectCourseCategory e => _onSelectCourseCategory(e, emit),
      final OnSearchQueryChanged e => _onSearchQueryChanged(e, emit),
      final OnSelectCourseLevel e => _onSelectCourseLevel(e, emit),
      final OnSelectCourseLanguage e => _onSelectCourseLanguage(e, emit),
      final OnSelectSubcategory e => _onSelectSubcategory(e, emit),
    };
  }

  void _onSelectSubcategory(
    OnSelectSubcategory event,
    Emitter<SearchCourseState> emit,
  ) {
    if (state.selectedSubcategoryIds.contains(event.subcategoryId)) {
      final updatedSubcategoryIds = state.selectedSubcategoryIds
          .where((id) => id != event.subcategoryId)
          .toList();
      emit(
        state.copyWith(
          selectedSubcategoryIds: updatedSubcategoryIds,
        ),
      );
    } else {
      final updatedSubcategoryIds = [
        ...state.selectedSubcategoryIds,
        event.subcategoryId
      ];
      emit(
        state.copyWith(
          selectedSubcategoryIds: updatedSubcategoryIds,
        ),
      );
    }
  }

  void _onSelectCourseLanguage(
    OnSelectCourseLanguage event,
    Emitter<SearchCourseState> emit,
  ) {
    if (state.selectedLanguageIds.contains(event.languageId)) {
      final updatedLanguageIds = state.selectedLanguageIds
          .where((id) => id != event.languageId)
          .toList();
      emit(
        state.copyWith(
          selectedLanguageIds: updatedLanguageIds,
        ),
      );
    } else {
      final updatedLanguageIds = [
        ...state.selectedLanguageIds,
        event.languageId
      ];
      emit(
        state.copyWith(
          selectedLanguageIds: updatedLanguageIds,
        ),
      );
    }
  }

  void _onSelectCourseLevel(
    OnSelectCourseLevel event,
    Emitter<SearchCourseState> emit,
  ) {
    if (state.selectedLevelIds.contains(event.levelId)) {
      final updatedLevelIds =
          state.selectedLevelIds.where((id) => id != event.levelId).toList();
      emit(
        state.copyWith(
          selectedLevelIds: updatedLevelIds,
        ),
      );
    } else {
      final updatedLevelIds = [...state.selectedLevelIds, event.levelId];
      emit(
        state.copyWith(
          selectedLevelIds: updatedLevelIds,
        ),
      );
    }
  }

  void _onSearchQueryChanged(
    OnSearchQueryChanged event,
    Emitter<SearchCourseState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  void _onSelectCourseCategory(
    OnSelectCourseCategory event,
    Emitter<SearchCourseState> emit,
  ) {
    if (state.selectedCategories.contains(event.category)) {
      final updatedCategories = state.selectedCategories
          .where((category) => category.id != event.category.id)
          .toList();
      emit(
        state.copyWith(
          selectedCategories: updatedCategories,
        ),
      );
    } else {
      final updatedCategories = [
        ...state.selectedCategories,
        event.category
      ];
      emit(
        state.copyWith(
          selectedCategories: updatedCategories,
        ),
      );
    }
  }

  Future<void> _onFetchCourses(
    OnFetchCourses event,
    Emitter<SearchCourseState> emit,
  ) async {
    emit(state.copyWith(coursesResult: const ApiResultLoading()));
    final filters = CourseFilters(
      categoryIds: state.selectedCategories.map((e) => e.id).toList(),
      searchQuery: state.searchQuery,
      languageIds: state.selectedLanguageIds,
      levelIds: state.selectedLevelIds,
      subcategoryIds: state.selectedSubcategoryIds,
    );
    final res = await _fetchCourses.call(filters);
    res.fold(
      (failure) => emit(state.copyWith(
          coursesResult: ApiResultFailure(failure.errorMessage))),
      (campaigns) =>
          emit(state.copyWith(coursesResult: ApiResultSuccess(campaigns))),
    );
  }
}
