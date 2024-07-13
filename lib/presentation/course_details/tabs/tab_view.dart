import 'package:education_app/presentation/course_details/tabs/about_tab.dart';
import 'package:education_app/presentation/course_details/tabs/curriculum_tab.dart';
import 'package:education_app/presentation/course_details/tabs/reviews_tab.dart';
import 'package:education_app/presentation/course_details/tabs/updates_tab.dart';
import 'package:education_app/state_management/course_details/course_details_bloc.dart';
import 'package:education_app/state_management/course_details/course_details_event.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsTabView extends StatefulWidget {
  const CourseDetailsTabView({
    super.key,
  });

  @override
  State<CourseDetailsTabView> createState() => _CourseDetailsTabViewState();
}

class _CourseDetailsTabViewState extends State<CourseDetailsTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const tabs = [
    "About",
    "Curriculum",
    "Reviews",
    "Updates",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    // Listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _handleTabIndexChange(_tabController.index);
      }
    });
  }

  @override
  void didUpdateWidget(CourseDetailsTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentTabIndex =
        context.read<CourseDetailsBloc>().state.currentTabIndex;
    if (_tabController.index != currentTabIndex) {
      _tabController.animateTo(currentTabIndex);
    }
  }

  void _handleTabIndexChange(int index) {
    context.read<CourseDetailsBloc>().add(OnTabIndexChanged(index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(int index, CourseDetailsState state) {
    final courseResult = state.courseResult;
    switch (index) {
      case 0:
        return CourseAboutTabContent();
      case 1:
        return const CurriculumTabContent();
      case 2:
        return CourseReviewsTabContent();
      case 3:
        return CourseUpdatesTabContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        var currentTabIndex = state.currentTabIndex;
        return Column(
          children: [
            TabBar(
              controller: _tabController,
              onTap: _handleTabIndexChange,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
              tabs: tabs
                  .map(
                    (tab) => Text(
                      tab,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  )
                  .toList(),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Container(
                // This key causes the AnimatedSwitcher to interpret this as a "new"
                // child each time the count changes, so that it will begin its animation
                // when the count changes.
                key: ValueKey<int>(currentTabIndex),
                child: _buildTabContent(currentTabIndex, state),
              ),
            ),
          ],
        );
      },
    );
  }
}
