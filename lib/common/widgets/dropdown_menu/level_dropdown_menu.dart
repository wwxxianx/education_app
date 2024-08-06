import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/dropdown_menu/custom_dropdown_menu.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_levels.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CourseLevelsState extends Equatable {
  final ApiResult<List<CourseLevel>> levelsResult;

  const CourseLevelsState({
    required this.levelsResult,
  });

  factory CourseLevelsState.initial() {
    return const CourseLevelsState(
      levelsResult: ApiResultInitial(),
    );
  }

  CourseLevelsState copyWith({
    ApiResult<List<CourseLevel>>? levelsResult,
  }) {
    return CourseLevelsState(
      levelsResult: levelsResult ?? this.levelsResult,
    );
  }

  @override
  List<Object> get props => [levelsResult];
}

class CourseLevelCubit extends Cubit<CourseLevelsState> {
  final FetchCourseLevels _fetchCourseLevels;
  CourseLevelCubit({required FetchCourseLevels fetchCourseLevels})
      : _fetchCourseLevels = fetchCourseLevels,
        super(CourseLevelsState.initial());

  Future<void> fetchCourseLevels() async {
    final res = await _fetchCourseLevels.call(NoPayload());
    res.fold(
      (failure) => emit(
          state.copyWith(levelsResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(state.copyWith(levelsResult: ApiResultSuccess(data))),
    );
  }
}

class CourseLevelDropdownMenu extends StatelessWidget {
  final void Function(String)? onSelected;
  final String? initialSelection;
  final String? errorText;
  const CourseLevelDropdownMenu({
    super.key,
    this.onSelected,
    this.initialSelection,
    this.errorText,
  });

  List<DropdownMenuEntry<String>> _buildDropdownMenuItems(
      ApiResult<List<CourseLevel>> courseLevels) {
    if (courseLevels is ApiResultSuccess<List<CourseLevel>>) {
      return courseLevels.data
          .map((e) =>
              DropdownMenuEntry(value: e.id, label: e.level.capitalize()))
          .toList();
    }
    return List.generate(
        1, (index) => const DropdownMenuEntry(value: "", label: "Loading..."));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseLevelCubit(
        fetchCourseLevels: serviceLocator(),
      )..fetchCourseLevels(),
      child: BlocBuilder<CourseLevelCubit, CourseLevelsState>(
        builder: (context, state) {
          final levelsResult = state.levelsResult;
          if (levelsResult is ApiResultLoading) {
            return Text("loading...");
          }
          if (levelsResult is ApiResultFailure) {
            return Text("error...");
          }
          if (levelsResult is ApiResultSuccess<List<CourseLevel>>) {
            return CustomDropdownMenu(
              label: 'Course level',
              errorText: errorText,
              initialSelection: initialSelection,
              dropdownMenuEntries: _buildDropdownMenuItems(levelsResult),
              onSelected: (languageId) {
                if (onSelected != null && languageId != null) {
                  onSelected!(languageId);
                }
              },
            );
          }
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
