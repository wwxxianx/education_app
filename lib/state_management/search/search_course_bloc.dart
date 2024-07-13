import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/state_management/search/search_course_event.dart';
import 'package:education_app/state_management/search/search_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCourseBloc
    extends Bloc<SearchCourseEvent, SearchCourseState> {
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
    };
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
    if (state.selectedCategoryIds.contains(event.categoryId)) {
      final updatedCategoryIds = state.selectedCategoryIds
          .where((id) => id != event.categoryId)
          .toList();
      emit(
        state.copyWith(
          selectedCategoryIds: updatedCategoryIds,
        ),
      );
    } else {
      final updatedCategoryIds = [
        ...state.selectedCategoryIds,
        event.categoryId
      ];
      emit(
        state.copyWith(
          selectedCategoryIds: updatedCategoryIds,
        ),
      );
    }
  }

  Future<void> _onFetchCourses(
    OnFetchCourses event,
    Emitter<SearchCourseState> emit,
  ) async {
    emit(state.copyWith(coursesResult: const ApiResultLoading()));
    final payload = FetchCoursePayload(
      categoryIds: state.selectedCategoryIds,
      searchQuery: state.searchQuery,
    );
    final res = await _fetchCourses.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          coursesResult: ApiResultFailure(failure.errorMessage))),
      (campaigns) =>
          emit(state.copyWith(coursesResult: ApiResultSuccess(campaigns))),
    );
  }
}
