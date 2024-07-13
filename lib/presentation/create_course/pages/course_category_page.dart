import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/common/widgets/error_hint.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCourseCategoryPage extends StatelessWidget {
  final VoidCallback onNextPage;
  const SelectCourseCategoryPage({
    super.key,
    required this.onNextPage,
  });

  void _handleSelectCategory(BuildContext context, String categoryId) {
    context
        .read<CreateCourseBloc>()
        .add(OnSelectCourseCategory(categoryId: categoryId));
  }

  void _handleSelectSubcategory(BuildContext context, String categoryId) {
    context
        .read<CreateCourseBloc>()
        .add(OnSelectCourseSubcategory(categoryId: categoryId));
  }

  void _handleSubmit(BuildContext context) {
    context.read<CreateCourseBloc>().add(ValidateRelationData(
      onSuccess: () {
        onNextPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseBloc, CreateCourseState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.screenHorizontalPadding,
                      right: Dimensions.screenHorizontalPadding,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Category (Select one)",
                          style: CustomFonts.labelMedium,
                        ),
                        if (state.categoryError != null)
                          ErrorLabel(errorText: state.categoryError),
                        8.kH,
                        CourseCategoryList(
                          onPressed: (category) {
                            _handleSelectCategory(context, category.id);
                          },
                          selectedCategoryIds: state.selectedCategoryId == null
                              ? []
                              : [state.selectedCategoryId!],
                          isSmall: true,
                        ),
                        24.kH,
                        const Text(
                          "Category (Select multiple)",
                          style: CustomFonts.labelMedium,
                        ),
                        if (state.subcategoryError != null)
                          ErrorLabel(errorText: state.subcategoryError),
                        8.kH,
                        if (state.selectedCategoryId == null)
                          Text(
                            "Please select a category first",
                            style: CustomFonts.labelSmall.copyWith(
                              color: CustomColors.textGrey,
                            ),
                          ),
                        if (state.selectedCategoryId != null)
                          CourseCategoryList(
                            subcategoryParentId: state.selectedCategoryId!,
                            selectedSubcategoryIds:
                                state.selectedSubcategoryIds,
                            onPressed: (subcategory) {
                              _handleSelectSubcategory(context, subcategory.id);
                            },
                            isSmall: true,
                          ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  _handleSubmit(context);
                                },
                                child: const Text("Continue"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
