import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/widgets/course/course_list_tile.dart';
import 'package:education_app/common/widgets/empty_illustration.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/state_management/my_learning/my_learning_bloc.dart';
import 'package:education_app/state_management/my_learning/my_learning_event.dart';
import 'package:education_app/state_management/my_learning/my_learning_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyLearningScreen extends StatelessWidget {
  static const route = '/my-learning';
  const MyLearningScreen({super.key});

  Widget _buildContent(BuildContext context) {
    final bloc = context.read<MyLearningBloc>();
    final coursesResult = bloc.state.coursesResult;
    if (coursesResult is ApiResultLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (coursesResult is ApiResultFailure<List<UserCourse>>) {
      return Text(
          coursesResult.errorMessage ?? "Failed to fetch your learning");
    }
    if (coursesResult is ApiResultSuccess<List<UserCourse>>) {
      if (coursesResult.data.isEmpty) {
        return const EmptyIllustration(
          title: "Seems like you haven't start any course",
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: coursesResult.data.length,
        itemBuilder: (context, index) {
          final course = coursesResult.data[index].course;
          return CourseListTile(
            course: course,
            onPressed: () {
              context.push("/my-learning/${course.id}");
            },
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyLearningBloc(fetchLearningCourses: serviceLocator())
            ..add(OnFetchMyLearningCourses()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Learning",
            style: CustomFonts.titleMedium,
          ),
        ),
        body: BlocBuilder<MyLearningBloc, MyLearningState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: _buildContent(context),
            );
          },
        ),
      ),
    );
  }
}
