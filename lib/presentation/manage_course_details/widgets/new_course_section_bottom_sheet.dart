import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/form/curriculum_form.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewCourseSectionBottomSheet extends StatefulWidget {
  final String courseId;
  const NewCourseSectionBottomSheet({
    super.key,
    required this.courseId,
  });

  @override
  State<NewCourseSectionBottomSheet> createState() =>
      _NewCourseSectionBottomSheetState();
}

class _NewCourseSectionBottomSheetState
    extends State<NewCourseSectionBottomSheet> {
  void _handleSubmit() {
    context.read<ManageCourseDetailsBloc>().add(OnCreateCourseSection(
          onSuccess: (data) {
            context.pop();
          },
          courseId: widget.courseId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          footer: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child:
                BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
              builder: (context, state) {
                return CustomButton(
                  isLoading: state.submitCourseSectionResult is ApiResultLoading,
                  onPressed: _handleSubmit,
                  child: Text("Add"),
                );
              },
            ),
          ),
          initialChildSize: 0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add NEW Section",
                  style: CustomFonts.titleMedium,
                ),
                20.kH,
                CurriculumForm(
                  onSectionTitleChanged: (value) {
                    context
                        .read<ManageCourseDetailsBloc>()
                        .add(OnSectionTitleChanged(value: value));
                  },
                  partFields: state.partFields,
                  onRemovePart: (partIndex) {
                    context
                        .read<ManageCourseDetailsBloc>()
                        .add(OnRemovePart(index: partIndex));
                  },
                  onAddPart: () {
                    context.read<ManageCourseDetailsBloc>().add(OnAddNewPart());
                  },
                  onPartTitleChanged: (partIndex, partTitleValue) {
                    context.read<ManageCourseDetailsBloc>().add(
                        OnPartTitleChanged(
                            index: partIndex, title: partTitleValue));
                  },
                  onSelectPartResourceFile: (partIndex, file) {
                    context
                        .read<ManageCourseDetailsBloc>()
                        .add(OnPartFileChanged(file: file, index: partIndex));
                  },
                  onRemovePartResourceFile: (partIndex) {
                    context
                        .read<ManageCourseDetailsBloc>()
                        .add(OnPartFileChanged(index: partIndex, file: null));
                  },
                  sectionTitleFieldLabel: "Section Title",
                  sectionTitleValue: state.sectionOneTitle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
