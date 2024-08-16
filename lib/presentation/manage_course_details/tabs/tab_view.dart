import 'package:education_app/presentation/course_details/tabs/reviews_tab.dart';
import 'package:education_app/presentation/manage_course_details/tabs/about_tab.dart';
import 'package:education_app/presentation/manage_course_details/tabs/curriculum_tab.dart';
import 'package:education_app/presentation/manage_course_details/tabs/reviews_tab.dart';
import 'package:education_app/presentation/manage_course_details/tabs/updates_tab.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCourseDetailsTabView extends StatefulWidget {
  final String courseId;
  const ManageCourseDetailsTabView({
    super.key,
    required this.courseId,
  });

  @override
  State<ManageCourseDetailsTabView> createState() =>
      _ManageCourseDetailsTabViewState();
}

class _ManageCourseDetailsTabViewState extends State<ManageCourseDetailsTabView>
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
  void didUpdateWidget(ManageCourseDetailsTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentTabIndex =
        context.read<ManageCourseDetailsBloc>().state.currentTabIndex;
    if (_tabController.index != currentTabIndex) {
      _tabController.animateTo(currentTabIndex);
    }
  }

  void _handleTabIndexChange(int index) {
    context.read<ManageCourseDetailsBloc>().add(OnTabIndexChanged(index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabContent(int index, ManageCourseDetailsState state) {
    final courseResult = state.courseResult;
    switch (index) {
      case 0:
        return ManageCourseAboutTabContent(
          courseId: widget.courseId,
        );
      case 1:
        return const ManageCourseCurriculumTabContent();
      case 2:
        return CourseReviewsTabContent(
          courseId: widget.courseId,
        );
      case 3:
        return ManageCourseUpdatesTabContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
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
