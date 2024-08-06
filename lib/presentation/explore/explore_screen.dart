import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/presentation/explore/widgets/avatar_header.dart';
import 'package:education_app/presentation/explore/widgets/continue_learning_bottom_sheet.dart';
import 'package:education_app/presentation/explore/widgets/popular_categories.dart';
import 'package:education_app/presentation/explore/widgets/popular_courses.dart';
import 'package:education_app/state_management/explore/explore_bloc.dart';
import 'package:education_app/state_management/explore/explore_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class ExploreScreen extends StatelessWidget {
  static const route = '/explore';
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ContinueLearningBottomSheet(),
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
            ],
          ),
        ),
      ),
    );
  }
}
