import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/dropdown_menu/custom_dropdown_menu.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_levels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseLevelCubit extends Cubit<ApiResult<List<CourseLevel>>> {
  final FetchCourseLevels _fetchCourseLevels;
  CourseLevelCubit({required FetchCourseLevels fetchCourseLevels})
      : _fetchCourseLevels = fetchCourseLevels,
        super(const ApiResultLoading());

  Future<void> fetchCourseLevels() async {
    final res = await _fetchCourseLevels.call(NoPayload());
    res.fold(
      (l) => emit(ApiResultFailure(l.errorMessage)),
      (r) => emit(ApiResultSuccess(r)),
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
      child: BlocBuilder<CourseLevelCubit, ApiResult<List<CourseLevel>>>(
        builder: (context, state) {
          if (state is ApiResultLoading) {
            return Text("loading...");
          }
          if (state is ApiResultFailure) {
            return Text("error...");
          }
          if (state is ApiResultSuccess<List<CourseLevel>>) {
            return CustomDropdownMenu(
              label: 'Course level',
              errorText: errorText,
              initialSelection: initialSelection,
              dropdownMenuEntries: _buildDropdownMenuItems(state),
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
