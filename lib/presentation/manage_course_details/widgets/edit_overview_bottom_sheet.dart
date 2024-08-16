import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditOverviewBottomSheet extends StatefulWidget {
  final String courseId;
  const EditOverviewBottomSheet({
    super.key,
    required this.courseId,
  });

  @override
  State<EditOverviewBottomSheet> createState() =>
      _EditOverviewBottomSheetState();
}

class _EditOverviewBottomSheetState extends State<EditOverviewBottomSheet> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    final courseResult =
        context.read<ManageCourseDetailsBloc>().state.courseResult;
    if (courseResult is ApiResultSuccess<Course> &&
        courseResult.data.description.isNotEmpty) {
      textController.text = courseResult.data.description;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _handleSubmit(BuildContext context) {
    final payload = UpdateCoursePayload(
      courseId: widget.courseId,
      description: textController.text,
    );
    context.read<ManageCourseDetailsBloc>().add(
          OnUpdateCourse(
              courseId: widget.courseId,
              payload: payload,
              onSuccess: () {
                context.pop();
              }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.6,
          footer: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
              vertical: 10,
            ),
            child: CustomButton(
              isLoading: state.updateCourseResult is ApiResultLoading,
              enabled: state.updateCourseResult is! ApiResultLoading,
              onPressed: () {
                _handleSubmit(context);
              },
              child: Text("Save changes"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Course Overview',
                  style: CustomFonts.labelMedium,
                ),
                8.kH,
                CustomOutlinedTextfield(
                  controller: textController,
                  label: "Course Overview",
                  maxLines: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
