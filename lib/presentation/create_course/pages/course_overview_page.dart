import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/presentation/create_course/widgets/topics_input_list.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;

class CourseOverviewPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const CourseOverviewPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<CourseOverviewPage> createState() => _CourseOverviewPageState();
}

class _CourseOverviewPageState extends State<CourseOverviewPage> {
  List<InputListTileItem> _getInitialTopics() {
    final topics = context.read<CreateCourseBloc>().state.topics;
    if (topics.isNotEmpty) {
      return topics
          .mapWithIndex((value, index) => InputListTileItem(index, value))
          .toList();
    }
    return List<InputListTileItem>.generate(
        5, (index) => InputListTileItem(index, ''));
  }

  List<InputListTileItem> _getInitialRequirements() {
    final requirements = context.read<CreateCourseBloc>().state.requirements;
    if (requirements.isNotEmpty) {
      return requirements
          .mapWithIndex((value, index) => InputListTileItem(index, value))
          .toList();
    }
    return List<InputListTileItem>.generate(
        5, (index) => InputListTileItem(index, ''));
  }

  void _syncTopics(List<InputListTileItem> inputListItems) {
    context
        .read<CreateCourseBloc>()
        .add(OnSyncTopics(topics: inputListItems.map((e) => e.text).toList()));
  }

  void _syncRequirements(List<InputListTileItem> inputListItems) {
    context.read<CreateCourseBloc>().add(OnSyncRequirements(
        requirements: inputListItems.map((e) => e.text).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseBloc, CreateCourseState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return WillPopScope(
              onWillPop: () async {
                widget.onPreviousPage();
                return false;
              },
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.screenHorizontalPadding,
                        right: Dimensions.screenHorizontalPadding,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'What can people learn from this course?',
                            style: CustomFonts.labelMedium,
                          ),
                          8.kH,
                          ReorderableInputList(
                            onInit: _getInitialTopics,
                            onFinished: _syncTopics,
                          ),
                          24.kH,
                          const Text(
                            'What are the prerequisites for this course?',
                            style: CustomFonts.labelMedium,
                          ),
                          8.kH,
                          ReorderableInputList(
                            onInit: _getInitialRequirements,
                            onFinished: _syncRequirements,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onPressed: widget.onNextPage,
                                  child: const Text("Continue"),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
