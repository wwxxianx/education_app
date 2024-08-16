import 'dart:io';

import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/common/widgets/media/file_picker.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_part_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewCoursePartBottomSheet extends StatefulWidget {
  final CourseSection selectedSection;
  final CoursePart? part;
  const NewCoursePartBottomSheet({
    super.key,
    required this.selectedSection,
    this.part,
  });

  @override
  State<NewCoursePartBottomSheet> createState() =>
      _NewCoursePartBottomSheetState();
}

class _NewCoursePartBottomSheetState extends State<NewCoursePartBottomSheet> {
  late final TextEditingController titleController;
  File? selectedResourceFile;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    if (widget.part != null) {
      titleController.text = widget.part!.title;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void _handleSelectFile(List<File> files) {
    setState(() {
      selectedResourceFile = files.first;
    });
  }

  void _handleSubmit() {
    if (widget.part == null) {
      // Create new
      final payload = CreateCoursePartPayload(
          sectionId: widget.selectedSection.id,
          title: titleController.text,
          resourceFile: selectedResourceFile!);
      context.read<ManageCourseDetailsBloc>().add(OnCreateCoursePart(
            payload: payload,
            onSuccess: (data) {
              context.pop();
            },
          ));
      return;
    }
    // Update
    context.read();
  }

  String get displayTitle {
    if (widget.part != null) {
      return "Edit ${widget.part?.title ?? ""}";
    }
    return "NEW part for Section ${widget.selectedSection.order} - ${widget.selectedSection.title}";
  }

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      footer: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
        child: BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
          builder: (context, state) {
            return CustomButton(
              isLoading: state.submitCoursePartResult is ApiResultLoading,
              onPressed: _handleSubmit,
              child: Text(widget.part == null ? "Add" : "Save changes"),
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
            Text(
              displayTitle,
              style: CustomFonts.titleMedium,
            ),
            20.kH,
            CustomOutlinedTextfield(
              label: "Part title",
              controller: titleController,
            ),
            12.kH,
            CustomFilePicker(
              label: "Learning resource",
              limit: 1,
              onSelected: _handleSelectFile,
              previewFileUrls:
                  widget.part != null ? [widget.part!.resource.url] : [],
            )
          ],
        ),
      ),
    );
  }
}
