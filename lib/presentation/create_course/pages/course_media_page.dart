import 'dart:io';

import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/media/media_picker.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseMediaPage extends StatelessWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const CourseMediaPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  void _handleImageFilesChanged(BuildContext context, List<File> files) {
    context.read<CreateCourseBloc>().add(OnAddCourseImageFile(files: files));
  }

  void _handleVideoFilesChanged(BuildContext context, List<File> files) {
    context
        .read<CreateCourseBloc>()
        .add(OnAddCourseVideoFile(file: files.first));
  }

  void _handleSubmit(BuildContext context) {
    context
        .read<CreateCourseBloc>()
        .add(ValidateMediaData(onSuccess: onNextPage));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseBloc, CreateCourseState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload course images (maximum 5)',
                      style: CustomFonts.labelMedium,
                    ),
                    8.kH,
                    MediaPicker(
                      limit: 5,
                      onSelected: (files) {
                        _handleImageFilesChanged(context, files);
                      },
                    ),
                    20.kH,
                    const Text(
                      'Upload course video (Optional, maximum 1)',
                      style: CustomFonts.labelMedium,
                    ),
                    8.kH,
                    MediaPicker(
                      isVideo: true,
                      limit: 1,
                      onSelected: (files) {
                        _handleVideoFilesChanged(context, files);
                      },
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
                        vertical: 10,
                        horizontal: Dimensions.screenHorizontalPadding),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CustomButton(
                        onPressed: () {
                          _handleSubmit(context);
                        },
                        child: Text("Next"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
