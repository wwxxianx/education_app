import 'dart:io';

import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/common/widgets/single_image_picker.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/instructor_profile_payload.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/presentation/my_course/my_course_screen.dart';
import 'package:education_app/presentation/onboarding_instructor/cubit/create_instructor_cubit.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateInstructorProfileBottomSheet extends StatefulWidget {
  const CreateInstructorProfileBottomSheet({super.key});

  @override
  State<CreateInstructorProfileBottomSheet> createState() =>
      _CreateInstructorProfileBottomSheetState();
}

class _CreateInstructorProfileBottomSheetState
    extends State<CreateInstructorProfileBottomSheet> {
  late TextEditingController fullNameController;
  late TextEditingController titleController;
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    final appUserState = context.read<AppUserCubit>().state;
    final currentUser = appUserState.currentUser;
    if (currentUser == null) {
      return;
    }
    fullNameController = TextEditingController(text: currentUser.fullName);
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void _handleSubmit(BuildContext context) {
    final payload = CreateInstructorProfilePayload(
      fullName: fullNameController.text,
      title: titleController.text,
      profileImageFile: selectedFile,
    );

    context.read<CreateInstructorProfileCubit>().onCreateInstructorProfile(
      payload,
      onSuccess: () {
        context.go(MyCourseScreen.route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateInstructorProfileCubit(
          createInstructorProfile: serviceLocator()),
      child: BlocBuilder<CreateInstructorProfileCubit,
          CreateInstructorProfileState>(
        builder: (context, state) {
          return CustomDraggableSheet(
            initialChildSize: 0.9,
            footer: SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding,
                  vertical: 10,
                ),
                child: CustomButton(
                  isLoading:
                      state.createInstructorProfileResult is ApiResultLoading,
                  enabled:
                      state.createInstructorProfileResult is! ApiResultLoading,
                  onPressed: () {
                    _handleSubmit(context);
                  },
                  child: Text("Create"),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Column(
                children: [
                  const Text(
                    'Your instructor profile',
                    style: CustomFonts.titleMedium,
                  ),
                  20.kH,
                  BlocBuilder<AppUserCubit, AppUserState>(
                    builder: (context, state) {
                      final currentUser = state.currentUser;
                      return SingleImagePicker(
                        size: 150,
                        onFileChanged: (file) {
                          setState(() {
                            selectedFile = file;
                          });
                        },
                        previewImageUrl: currentUser?.profileImageUrl,
                      );
                    },
                  ),
                  CustomOutlinedTextfield(
                    label: "Full Name",
                    controller: fullNameController,
                  ),
                  12.kH,
                  CustomOutlinedTextfield(
                    label: "Your title",
                    controller: titleController,
                    hintText: "Netflix Tech Lead",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
