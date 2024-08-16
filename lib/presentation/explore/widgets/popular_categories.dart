import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/toggle_button.dart';
import 'package:education_app/common/widgets/container/marquee.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course_category/course_category.dart';
import 'package:education_app/presentation/search/search_screen.dart';
import 'package:education_app/state_management/search/search_course_bloc.dart';
import 'package:education_app/state_management/search/search_course_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({super.key});

  void _handleCategoryPressed(BuildContext context, CourseCategory category) {
    context
        .read<SearchCourseBloc>()
        .add(OnSelectCourseCategory(category: category));
    context.push(SearchScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseCategoriesCubit(fetchAllCourseCategories: serviceLocator())
            ..fetchCourseCategories(),
      child: BlocBuilder<CourseCategoriesCubit, CourseCategoriesState>(
        builder: (context, state) {
          final categoriesResult = state.categoriesResult;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(left: Dimensions.screenHorizontalPadding),
                child: Text(
                  "Popular Categories",
                  style: CustomFonts.labelLarge,
                ),
              ),
              12.kH,
              if (categoriesResult is ApiResultSuccess<List<CourseCategory>>)
                MarqueeListView(
                  animationSeconds: 6,
                  height: 44,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final category = categoriesResult.data[index];
                    return Container(
                      key: ValueKey(category.id),
                      margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 0,
                        right: 12,
                      ),
                      child: CustomToggleButton(
                        isSelected: true,
                        onTap: () {
                          _handleCategoryPressed(context, category);
                        },
                        child: Row(
                          children: [
                            category.getIcon(),
                            4.kW,
                            Text(
                              category.title,
                              style: CustomFonts.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              12.kH,
              if (categoriesResult is ApiResultSuccess<List<CourseCategory>>)
                MarqueeListView(
                  animationSeconds: 10,
                  height: 44,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final category = categoriesResult.data[index + 3];
                    return Container(
                      key: ValueKey(category.id),
                      margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 0,
                        right: 12,
                      ),
                      child: CustomToggleButton(
                        isSelected: true,
                        onTap: () {
                          _handleCategoryPressed(context, category);
                        },
                        child: Row(
                          children: [
                            category.getIcon(),
                            4.kW,
                            Text(
                              category.title,
                              style: CustomFonts.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
