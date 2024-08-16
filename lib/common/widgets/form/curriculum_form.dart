import 'dart:io';

import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/common/widgets/media/file_picker.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CurriculumForm extends StatefulWidget {
  final String? sectionTitleValue;
  final String sectionTitleFieldLabel;
  final void Function(String value) onSectionTitleChanged;
  final List<CoursePartField> partFields;
  final void Function(int partIndex) onRemovePart;
  final void Function() onAddPart;
  final void Function(int partIndex, String partTitleValue) onPartTitleChanged;
  final void Function(int partIndex, File file) onSelectPartResourceFile;
  final void Function(int partIndex) onRemovePartResourceFile;
  const CurriculumForm({
    super.key,
    required this.onSectionTitleChanged,
    required this.partFields,
    required this.onRemovePart,
    required this.onAddPart,
    required this.onPartTitleChanged,
    required this.onSelectPartResourceFile,
    required this.onRemovePartResourceFile,
    required this.sectionTitleFieldLabel,
    required this.sectionTitleValue,
  });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      "How to organize your course?",
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
                  style: CustomFonts.bodySmall
                      .copyWith(color: CustomColors.primaryBlue),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Part 1.",
                    style: CustomFonts.bodySmall
                        .copyWith(color: CustomColors.primaryBlue),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Part 2.",
                    style: CustomFonts.bodySmall
                        .copyWith(color: CustomColors.primaryBlue),
                  ),
                )
              ],
            ),
          ),
          16.kH,
          CustomOutlinedTextfield(
            label: widget.sectionTitleFieldLabel,
            initialValue: widget.sectionTitleValue,
            onChanged: (value) {
              widget.onSectionTitleChanged(value);
            },
          ),
          12.kH,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.partFields.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CustomColors.containerBorderGrey),
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
                        // Remove button
                        IconButton(
                          onPressed: () {
                            widget.onRemovePart(index);
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
                      initialValue: widget.partFields[index].title,
                      onChanged: (value) {
                        widget.onPartTitleChanged(index, value);
                      },
                    ),
                    12.kH,
                    Text(
                      "Learning resource:",
                      style: CustomFonts.labelSmall,
                    ),
                    CustomFilePicker(
                      previewFiles:
                          widget.partFields[index].resourceFile != null
                              ? [widget.partFields[index].resourceFile!]
                              : [],
                      limit: 1,
                      onSelected: (files) {
                        widget.onSelectPartResourceFile(index, files.first);
                      },
                      onRemove: (file) {
                        widget.onRemovePartResourceFile(index);
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
              // context.read<CreateCourseBloc>().add(OnAddNewPart());
              widget.onAddPart();
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
  }
}
