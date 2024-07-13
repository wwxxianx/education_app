import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
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
        .add(OnSelectCourseCategory(categoryId: courseCategory.id));
  }

  void _handleApplyFilter(BuildContext context) {
    context.read<SearchCourseBloc>().add(OnFetchCourses());
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCourseBloc, SearchCourseState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          footer: Row(
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
                selectedCategoryIds: state.selectedCategoryIds,
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
                "Location",
                style: CustomFonts.labelMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
