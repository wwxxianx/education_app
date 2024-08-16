import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/course_details/tabs/curriculum_tab.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_bloc.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_event.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LearningDetailsCurriculumTabContent extends StatelessWidget {
  final String courseId;
  const LearningDetailsCurriculumTabContent({
    super.key,
    required this.courseId,
  });

  Widget _buildContent(BuildContext context) {
    final bloc = context.watch<MyLearningDetailsBloc>();
    final courseResult = bloc.state.courseResult;
    final currentPart = bloc.state.currentPart;
    if (courseResult is ApiResultLoading) {
      return const CircularProgressIndicator();
    }
    if (courseResult is ApiResultSuccess<Course>) {
      return CurriculumContent(
        currentFocusPart: currentPart,
        sections: courseResult.data.sections,
        onPartContentPressed: (sectionIndex, partContent) {
          context.read<MyLearningDetailsBloc>().add(OnCurrentPartChanged(
                part: partContent,
                courseId: courseId,
                onSuccess: (data) {
                  context.read<AppUserCubit>().updateRecentCourseProgress(data);
                  var logger = Logger();
                  logger.e(currentPart);
                },
              ));
        },
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLearningDetailsBloc, MyLearningDetailsState>(
      builder: (context, state) {
        return _buildContent(context);
      },
    );
  }
}
