import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/common/widgets/course/language_toggle_list.dart';
import 'package:education_app/common/widgets/course/course_level_toggle_list.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/state_management/search/search_course_bloc.dart';
import 'package:education_app/state_management/search/search_course_event.dart';
import 'package:education_app/state_management/search/search_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseFilterBottomSheet extends StatelessWidget {
  const CourseFilterBottomSheet({
    super.key,
  });

  void _handleSelectCategory(
      BuildContext context, CourseCategory courseCategory) {
    context
        .read<SearchCourseBloc>()
        .add(OnSelectCourseCategory(category: courseCategory));
  }

  void _handleSelectLevel(BuildContext context, CourseLevel level) {
    context
        .read<SearchCourseBloc>()
        .add(OnSelectCourseLevel(levelId: level.id));
  }

  void _handleSelectLanguage(BuildContext context, Language language) {
    context
        .read<SearchCourseBloc>()
        .add(OnSelectCourseLanguage(languageId: language.id));
  }

  void _handleApplyFilter(BuildContext context) {
    context.read<SearchCourseBloc>().add(OnFetchCourses());
    context.pop();
  }

  void _handleSelectSubcategory(
      BuildContext context, CourseCategory subcategory) {
    context
        .read<SearchCourseBloc>()
        .add(OnSelectSubcategory(subcategoryId: subcategory.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCourseBloc, SearchCourseState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.9,
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onPressed: () {
                    _handleApplyFilter(context);
                  },
                  child: const Text("Apply filter"),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Category",
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                CourseCategoryList(
                  isSmall: true,
                  onPressed: (courseCategory) {
                    _handleSelectCategory(context, courseCategory);
                  },
                  selectedCategoryIds:
                      state.selectedCategories.map((e) => e.id).toList(),
                ),
                20.kH,
                const Text(
                  "Sub-categories",
                  style: CustomFonts.labelMedium,
                ),
                8.kH,
                if (state.selectedCategories.isNotEmpty)
                  ...state.selectedCategories.map((parentCategory) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parentCategory.title,
                          style: CustomFonts.labelSmall
                              .copyWith(color: CustomColors.textGrey),
                        ),
                        6.kH,
                        CourseCategoryList(
                          subcategoryParentId: parentCategory.id,
                          selectedSubcategoryIds: state.selectedSubcategoryIds,
                          onPressed: (subcategory) {
                            _handleSelectSubcategory(context, subcategory);
                          },
                          isSmall: true,
                        ),
                        4.kH,
                      ],
                    );
                  }).toList(),
                20.kH,
                //Divider
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: CustomColors.divider,
                  ),
                ),
                20.kH,
                const Text(
                  "Level",
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                CourseLevelToggleList(
                  onPressed: (level) {
                    _handleSelectLevel(context, level);
                  },
                  isSmall: true,
                  selectedLevelIds: state.selectedLevelIds,
                ),
                20.kH,
                //Divider
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: CustomColors.divider,
                  ),
                ),
                20.kH,
                const Text(
                  "Language",
                  style: CustomFonts.labelMedium,
                ),
                12.kH,
                LanguageToggleList(
                  onPressed: (language) {
                    _handleSelectLanguage(context, language);
                  },
                  selectedLanguageIds: state.selectedLanguageIds,
                  isSmall: true,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
