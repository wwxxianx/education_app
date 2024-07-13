import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/common/widgets/button/toggle_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/usecases/course_category/fetch_all_course_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CourseCategoriesCubit extends Cubit<ApiResult<List<CourseCategory>>> {
  final FetchAllCourseCategories _fetchAllCourseCategories;
  CourseCategoriesCubit({
    required FetchAllCourseCategories fetchAllCourseCategories,
  })  : _fetchAllCourseCategories = fetchAllCourseCategories,
        super(const ApiResultLoading());

  Future<void> fetchCampaignCategories() async {
    final res = await _fetchAllCourseCategories.call(NoPayload());
    res.fold(
      (l) => emit(ApiResultFailure(l.errorMessage)),
      (r) => emit(ApiResultSuccess(r)),
    );
  }
}

class CourseCategoryList extends StatelessWidget {
  final bool isSmall;
  final List<String> selectedCategoryIds;
  final List<String> selectedSubcategoryIds;
  final void Function(CourseCategory courseCategory) onPressed;
  final String? subcategoryParentId;

  const CourseCategoryList({
    super.key,
    required this.onPressed,
    this.selectedCategoryIds = const [],
    this.selectedSubcategoryIds = const [],
    this.isSmall = false,
    this.subcategoryParentId,
  });

  List<Widget> _buildContent(ApiResult courseCategories) {
    if (subcategoryParentId != null) {
      if (courseCategories is ApiResultSuccess<List<CourseCategory>>) {
        final category = courseCategories.data
            .firstWhere((category) => category.id == subcategoryParentId);
        return category.subcategories.map((subcategory) {
          return CustomToggleButton(
            padding: isSmall
                ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0)
                : null,
            isSelected: selectedSubcategoryIds.contains(subcategory.id),
            onTap: () {
              onPressed(subcategory);
            },
            child: Text(
              subcategory.title,
              style: isSmall
                  ? CustomFonts.labelExtraSmall
                  : CustomFonts.labelMedium,
            ),
          );
        }).toList();
      }
    }
    if (courseCategories is ApiResultLoading ||
        courseCategories is ApiResultFailure) {
      return List.generate(5, (index) {
        return const Skeleton(
          radius: 100,
        );
      });
    }
    return (courseCategories as ApiResultSuccess<List<CourseCategory>>)
        .data
        .map(
      (category) {
        return CustomToggleButton(
          padding: isSmall
              ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0)
              : null,
          isSelected: selectedCategoryIds.contains(category.id),
          onTap: () {
            onPressed(category);
          },
          child: Text(
            category.title,
            style:
                isSmall ? CustomFonts.labelExtraSmall : CustomFonts.labelMedium,
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseCategoriesCubit(fetchAllCourseCategories: serviceLocator())
            ..fetchCampaignCategories(),
      child:
          BlocBuilder<CourseCategoriesCubit, ApiResult<List<CourseCategory>>>(
        builder: (context, state) {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.horizontal,
            children: _buildContent(state),
          );
        },
      ),
    );
  }
}
