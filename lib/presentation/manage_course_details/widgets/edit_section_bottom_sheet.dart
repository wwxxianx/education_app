import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_section_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditSectionBottomSheet extends StatefulWidget {
  final CourseSection section;
  const EditSectionBottomSheet({
    super.key,
    required this.section,
  });

  @override
  State<EditSectionBottomSheet> createState() => _EditSectionBottomSheetState();
}

class _EditSectionBottomSheetState extends State<EditSectionBottomSheet> {
  late final TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.section.title);
    titleController.text = widget.section.title;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    context.read<ManageCourseDetailsBloc>().add(OnUpdateCourseSection(
          payload: UpdateCourseSectionPayload(
              sectionId: widget.section.id, title: titleController.text),
          onSuccess: (data) {
            context.pop();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.9,
          footer: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child: CustomButton(
              isLoading: state.submitCourseSectionResult is ApiResultLoading,
              onPressed: _handleSubmit,
              child: Text("Save changes"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Section ${widget.section.order} - ${widget.section.title}",
                  style: CustomFonts.titleMedium,
                ),
                12.kH,
                CustomOutlinedTextfield(
                  controller: titleController,
                  label: "Section Title",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
