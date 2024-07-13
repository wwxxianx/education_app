import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/widgets/course/course_list_tile.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/create_course/create_course_screen.dart';
import 'package:education_app/state_management/my_course/my_course_bloc.dart';
import 'package:education_app/state_management/my_course/my_course_event.dart';
import 'package:education_app/state_management/my_course/my_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class MyCourseScreen extends StatelessWidget {
  static const route = '/my-course';
  const MyCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCourseBloc()..add(OnFetchMyCourses()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Courses",
            style: CustomFonts.titleMedium,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: CustomColors.primaryBlue,
          shape: const CircleBorder(),
          onPressed: () {
            context.push(CreateCourseScreen.route);
          },
          child: const HeroIcon(HeroIcons.plus),
        ),
        body: const SingleChildScrollView(
          child: MyCoursesList(),
        ),
      ),
    );
  }
}

class MyCoursesList extends StatelessWidget {
  const MyCoursesList({super.key});

  void _navigateToCourseDetails(BuildContext context, Course course) {
    context.push('/my-course/${course.id}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCourseBloc, MyCourseState>(
      builder: (context, state) {
        final myCoursesResult = state.myCoursesResult;
        if (myCoursesResult is ApiResultSuccess<List<Course>>) {
          if (myCoursesResult.data.isEmpty) {
            return Text("Empty");
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: myCoursesResult.data.length,
            itemBuilder: (context, index) {
              final course = myCoursesResult.data[index];
              return CourseListTile(
                course: course,
                showStatusChip: true,
                onPressed: () {
                  _navigateToCourseDetails(context, course);
                },
              );
            },
          );
        }
        if (myCoursesResult is ApiResultLoading) {
          return Text("Loading...");
        }
        if (myCoursesResult is ApiResultFailure) {
          return Text("Failure...");
        }
        return Container();
      },
    );
  }
}
