import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/common/widgets/button/toggle_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/domain/usecases/course_category/fetch_all_course_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CourseCategoriesState extends Equatable {
  final ApiResult<List<CourseCategory>> categoriesResult;

  const CourseCategoriesState({
    required this.categoriesResult,
  });

  factory CourseCategoriesState.initial() {
    return const CourseCategoriesState(
      categoriesResult: ApiResultInitial(),
    );
  }

  CourseCategoriesState copyWith({
    ApiResult<List<CourseCategory>>? categoriesResult,
  }) {
    return CourseCategoriesState(
      categoriesResult: categoriesResult ?? this.categoriesResult,
    );
  }

  @override
  List<Object> get props => [categoriesResult];
}

class CourseCategoriesCubit extends Cubit<CourseCategoriesState> {
  final FetchAllCourseCategories _fetchAllCourseCategories;
  CourseCategoriesCubit({
    required FetchAllCourseCategories fetchAllCourseCategories,
  })  : _fetchAllCourseCategories = fetchAllCourseCategories,
        super(CourseCategoriesState.initial());

  Future<void> fetchCourseCategories() async {
    final res = await _fetchAllCourseCategories.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          categoriesResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(state.copyWith(categoriesResult: ApiResultSuccess(data))),
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

  List<Widget> _buildContent(ApiResult<List<CourseCategory>> courseCategories) {
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
    if (courseCategories is ApiResultSuccess<List<CourseCategory>>) {
      return courseCategories.data.map(
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
    return BlocProvider(
      create: (context) => CourseCategoriesCubit(fetchAllCourseCategories: serviceLocator())..fetchCourseCategories(),
      child: BlocBuilder<CourseCategoriesCubit, CourseCategoriesState>(
        builder: (context, state) {
          final categoriesResult = state.categoriesResult;
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.horizontal,
            children: _buildContent(categoriesResult),
          );
        },
      ),
    );
  }
}
