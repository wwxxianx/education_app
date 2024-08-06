import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/widgets/button/toggle_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/common/widgets/dropdown_menu/level_dropdown_menu.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseLevelToggleList extends StatelessWidget {
  final bool isSmall;
  final List<String> selectedLevelIds;
  final void Function(CourseLevel level) onPressed;

  const CourseLevelToggleList({
    super.key,
    required this.onPressed,
    this.selectedLevelIds = const [],
    this.isSmall = false,
  });

  List<Widget> _buildContent(ApiResult<List<CourseLevel>> courseLevels) {
    if (courseLevels is ApiResultSuccess<List<CourseLevel>>) {
      return courseLevels.data.map(
        (category) {
          return CustomToggleButton(
            padding: isSmall
                ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0)
                : null,
            isSelected: selectedLevelIds.contains(category.id),
            onTap: () {
              onPressed(category);
            },
            child: Text(
              category.level,
              style: isSmall
                  ? CustomFonts.labelExtraSmall
                  : CustomFonts.labelMedium,
            ),
          );
        },
      ).toList();
    }
    return List.generate(5, (index) {
      return const Skeleton(
        radius: 100,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseLevelCubit, CourseLevelsState>(
      builder: (context, state) {
        final levelsResult = state.levelsResult;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          direction: Axis.horizontal,
          children: _buildContent(levelsResult),
        );
      },
    );
  }
}
