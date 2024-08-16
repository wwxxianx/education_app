import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/presentation/explore/widgets/avatar_header.dart';
import 'package:education_app/presentation/explore/widgets/continue_learning_bottom_sheet.dart';
import 'package:education_app/presentation/explore/widgets/popular_categories.dart';
import 'package:education_app/presentation/explore/widgets/popular_courses.dart';
import 'package:education_app/presentation/explore/widgets/recommended_course_from_preference.dart';
import 'package:education_app/presentation/explore/widgets/recommended_course_from_purchase_list.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/app_user_state.dart';
import 'package:education_app/state_management/explore/explore_bloc.dart';
import 'package:education_app/state_management/explore/explore_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  static const route = '/explore';
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ExploreBloc>()..add(OnFetchPopularCourses())..add(OnFetchPurchaseRecommendedCourse())..add(OnFetchPreferenceRecommendedCourse());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        final recentCourseProgress = state.recentCourseProgress;
        return Scaffold(
          bottomSheet: recentCourseProgress != null
              ? ContinueLearningBottomSheet(
                  courseProgress: recentCourseProgress,
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () {
              context.read<ExploreBloc>().add(OnFetchPopularCourses());
              return Future<void>.value();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarHeader(
                    title: 'Welcome back!',
                  ),
                  24.kH,
                  PopularCourses(),
                  24.kH,
                  PopularCategories(),
                  RecommendedCourseFromPurchaseList(),
                  RecommendedCourseFromPreference(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
