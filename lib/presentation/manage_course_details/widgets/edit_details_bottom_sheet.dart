import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/common/widgets/dropdown_menu/level_dropdown_menu.dart';
import 'package:education_app/common/widgets/error_hint.dart';
import 'package:education_app/common/widgets/input/money_input.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditCourseDetailsBottomSheet extends StatelessWidget {
  final String courseId;
  const EditCourseDetailsBottomSheet({super.key, required this.courseId});

  void _handleSelectCategory(BuildContext context, String categoryId) {
    context
        .read<ManageCourseDetailsBloc>()
        .add(OnSelectCourseCategory(categoryId: categoryId));
  }

  void _handleSelectSubcategory(BuildContext context, String categoryId) {
    context
        .read<ManageCourseDetailsBloc>()
        .add(OnSelectCourseSubcategory(categoryId: categoryId));
  }

  void _handleSelectLevel(BuildContext context, String id) {
    context.read<ManageCourseDetailsBloc>().add(OnSelectLevel(levelId: id));
  }

  void _handleTitleChanged(BuildContext context, String value) {
    context.read<ManageCourseDetailsBloc>().add(OnTitleChanged(value: value));
  }

  void _handlePriceChanged(BuildContext context, String value) {
    context.read<ManageCourseDetailsBloc>().add(OnPriceChanged(value: value));
  }

  void _handleSubmit(BuildContext context) {
    context.read<ManageCourseDetailsBloc>().add(
          OnUpdateCourse(
              courseId: courseId,
              onSuccess: () {
                context.pop();
              }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.6,
          footer: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
              vertical: 10,
            ),
            child: CustomButton(
              isLoading: state.updateCourseResult is ApiResultLoading,
              enabled: state.updateCourseResult is! ApiResultLoading,
              onPressed: () {
                _handleSubmit(context);
              },
              child: Text("Save changes"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Course Details',
                  style: CustomFonts.titleMedium,
                ),
                8.kH,
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
                  "Sub-category (Select multiple)",
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
                    selectedSubcategoryIds: state.selectedSubcategoryIds,
                    onPressed: (subcategory) {
                      _handleSelectSubcategory(context, subcategory.id);
                    },
                    isSmall: true,
                  ),
                24.kH,
                CustomOutlinedTextfield(
                  initialValue: state.titleText,
                  label: "Title",
                  onChanged: (value) {
                    _handleTitleChanged(context, value);
                  },
                ),
                20.kH,
                CourseLevelDropdownMenu(
                  onSelected: (id) {
                    _handleSelectLevel(context, id);
                  },
                  initialSelection: state.selectedLevelId,
                ),
                20.kH,
                MoneyTextField(
                  initialValue: state.priceText,
                  onChanged: (value) {
                    _handlePriceChanged(context, value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
