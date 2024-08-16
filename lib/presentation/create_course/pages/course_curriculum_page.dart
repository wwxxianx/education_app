import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/form/curriculum_form.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCurriculumPage extends StatefulWidget {
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;

  const CourseCurriculumPage({
    super.key,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  @override
  State<CourseCurriculumPage> createState() => _CourseCurriculumPageState();
}

class _CourseCurriculumPageState extends State<CourseCurriculumPage> {
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
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.screenHorizontalPadding),
                      child: Column(
                        children: [
                          const Text(
                            'Let’s create the first section for your class! Don’t worry, you can keep adding more sections later on.',
                            style: CustomFonts.labelMedium,
                          ),
                          8.kH,
                          CurriculumForm(
                            sectionTitleValue: state.sectionOneTitle,
                            onAddPart: () {
                              context
                                  .read<CreateCourseBloc>()
                                  .add(OnAddNewPart());
                            },
                            onPartTitleChanged: (partIndex, partTitleValue) {
                              context.read<CreateCourseBloc>().add(
                                  OnPartTitleChanged(
                                      index: partIndex, title: partTitleValue));
                            },
                            onRemovePart: (partIndex) {
                              context
                                  .read<CreateCourseBloc>()
                                  .add(OnRemovePart(index: partIndex));
                            },
                            onRemovePartResourceFile: (partIndex) {
                              context.read<CreateCourseBloc>().add(
                                  OnPartFileChanged(
                                      index: partIndex, file: null));
                            },
                            onSectionTitleChanged: (value) {},
                            onSelectPartResourceFile: (partIndex, file) {
                              context.read<CreateCourseBloc>().add(
                                  OnPartFileChanged(
                                      index: partIndex, file: file));
                            },
                            partFields: state.partFields,
                            sectionTitleFieldLabel: "Section 1 title",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.screenHorizontalPadding),
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 42,
                            child: CustomButton(
                              height: 42,
                              onPressed: widget.onNextPage,
                              child: const Text("Continue"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
