import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/create_course/widgets/topics_input_list.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:go_router/go_router.dart';

class EditRequirementBottomSheet extends StatefulWidget {
  final String courseId;
  const EditRequirementBottomSheet({
    super.key,
    required this.courseId,
  });

  @override
  State<EditRequirementBottomSheet> createState() =>
      _EditRequirementBottomSheetState();
}

class _EditRequirementBottomSheetState
    extends State<EditRequirementBottomSheet> {
  List<InputListTileItem> inputItems =
      List.generate(3, (index) => InputListTileItem(index, ""));

  List<InputListTileItem> _initInputItem(BuildContext context) {
    final courseResult =
        context.read<ManageCourseDetailsBloc>().state.courseResult;
    if (courseResult is ApiResultSuccess<Course>) {
      if (courseResult.data.requirements.isNotEmpty) {
        return courseResult.data.requirements
            .mapWithIndex(
                (requirement, index) => InputListTileItem(index, requirement))
            .toList();
      }
    }
    return inputItems;
  }

  void _handleSubmit(BuildContext context) {
    print("state req: ${inputItems.map((e) => e.text).toList()}");
    final payload = UpdateCoursePayload(
      courseId: widget.courseId,
      requirements: inputItems.map((e) => e.text).toList(),
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
              child: const Text("Save changes"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What are the prerequisites for this course?',
                  style: CustomFonts.labelMedium,
                ),
                8.kH,
                ReorderableInputList(
                  onInit: () {
                    return _initInputItem(context);
                  },
                  onFinished: (items) {
                    setState(() {
                      inputItems = items;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
