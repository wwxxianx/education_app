import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/course_details/tabs/curriculum_tab.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_bloc.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_event.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningDetailsCurriculumTabContent extends StatelessWidget {
  const LearningDetailsCurriculumTabContent({super.key});

  Widget _buildContent(BuildContext context) {
    final bloc = context.read<MyLearningDetailsBloc>();
    final courseResult = bloc.state.courseResult;
    if (courseResult is ApiResultLoading) {
      return Text("Loading...");
    }
    if (courseResult is ApiResultSuccess<Course>) {
      return CurriculumContent(
        sections: courseResult.data.sections,
        onPartContentPressed: (sectionIndex, partContent) {
          context
              .read<MyLearningDetailsBloc>()
              .add(OnCurrentPartChanged(part: partContent));
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
