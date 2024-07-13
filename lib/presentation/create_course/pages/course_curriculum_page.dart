import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/common/widgets/media/file_picker.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: CustomColors.lightBlue,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const HeroIcon(
                                      HeroIcons.questionMarkCircle,
                                      size: 20,
                                      color: CustomColors.primaryBlue,
                                    ),
                                    6.kW,
                                    Text(
                                      "How to organiza your course?",
                                      style: CustomFonts.labelSmall.copyWith(
                                        color: CustomColors.primaryBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                8.kH,
                                const Text(
                                  "Split your course into sections and parts.",
                                ),
                                2.kH,
                                Text(
                                  "Section 1.",
                                  style: CustomFonts.bodySmall.copyWith(
                                      color: CustomColors.primaryBlue),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    "Part 1.",
                                    style: CustomFonts.bodySmall.copyWith(
                                        color: CustomColors.primaryBlue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    "Part 2.",
                                    style: CustomFonts.bodySmall.copyWith(
                                        color: CustomColors.primaryBlue),
                                  ),
                                )
                              ],
                            ),
                          ),
                          12.kH,
                          CurriculumForm(),
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

class CurriculumForm extends StatefulWidget {
  const CurriculumForm({super.key});

  @override
  State<CurriculumForm> createState() => _CurriculumFormState();
}

class _CurriculumFormState extends State<CurriculumForm> {
  late TextEditingController sectionTitleController;

  @override
  void initState() {
    super.initState();
    sectionTitleController = TextEditingController();
  }

  @override
  void dispose() {
    sectionTitleController.dispose();
    super.dispose();
  }

  void _handleSectionTitleChanged(String value) {
    context.read<CreateCourseBloc>().add(OnSectionTitleChanged(value: value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseBloc, CreateCourseState>(
      builder: (context, state) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section 1:',
                style: CustomFonts.labelMedium,
              ),
              CustomOutlinedTextfield(
                label: "Section 1 title",
                onChanged: _handleSectionTitleChanged,
              ),
              12.kH,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.partFields.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: CustomColors.containerBorderGrey),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Part ${index + 1}:',
                              style: CustomFonts.labelMedium,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<CreateCourseBloc>()
                                    .add(OnRemovePart(index: index));
                              },
                              icon: const HeroIcon(
                                HeroIcons.trash,
                                size: 20,
                                color: CustomColors.alert,
                              ),
                            ),
                          ],
                        ),
                        8.kH,
                        CustomOutlinedTextfield(
                          label: "Part ${index + 1} title",
                          initialValue: state.partFields[index].title,
                          onChanged: (value) {
                            context.read<CreateCourseBloc>().add(
                                OnPartTitleChanged(index: index, title: value));
                          },
                        ),
                        12.kH,
                        Text(
                          "Learning resource:",
                          style: CustomFonts.labelSmall,
                        ),
                        CustomFilePicker(
                          previewFiles:
                              state.partFields[index].resourceFile != null
                                  ? [state.partFields[index].resourceFile!]
                                  : [],
                          limit: 1,
                          onSelected: (files) {
                            context.read<CreateCourseBloc>().add(
                                OnPartFileChanged(
                                    index: index, file: files.first));
                          },
                          onRemove: (file) {
                            context.read<CreateCourseBloc>().add(
                                OnPartFileChanged(index: index, file: null));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              12.kH,
              CustomButton(
                style: CustomButtonStyle.secondaryBlue,
                onPressed: () {
                  print(state.partFields.first.resourceFile);
                  context.read<CreateCourseBloc>().add(OnAddNewPart());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HeroIcon(
                      HeroIcons.plus,
                      size: 20,
                      color: CustomColors.primaryBlue,
                    ),
                    6.kW,
                    Text(
                      "Add one more part",
                      style: CustomFonts.labelMedium.copyWith(
                        color: CustomColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
