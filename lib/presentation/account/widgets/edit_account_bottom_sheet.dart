import 'dart:io';

import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/phone_input_formatter.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/common/widgets/single_image_picker.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/user_profile/user_profile_bloc.dart';
import 'package:education_app/state_management/user_profile/user_profile_event.dart';
import 'package:education_app/state_management/user_profile/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditAccountBottomSheet extends StatefulWidget {
  const EditAccountBottomSheet({super.key});

  @override
  State<EditAccountBottomSheet> createState() => _EditAccountBottomSheetState();
}

class _EditAccountBottomSheetState extends State<EditAccountBottomSheet> {
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberController;
  File? selectedImageFile;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appUserState = context.read<AppUserCubit>().state;
    final currentUser = appUserState.currentUser;
    if (currentUser != null) {
      fullNameController.text = currentUser.fullName;
      phoneNumberController.text = currentUser.phoneNumber ?? "";
    }
  }

  void _handleSubmit(BuildContext context) {
    final bloc = context.read<UserProfileBloc>();
    final appUserCubit = context.read<AppUserCubit>();
    final fullName = fullNameController.text;
    final phoneNumber = phoneNumberController.text;
    final payload = UserProfilePayload(
      fullName: fullName,
      phoneNumber: phoneNumber,
      profileImageFile: selectedImageFile,
    );
    bloc.add(
      OnUpdateUserProfile(
        payload: payload,
        onSuccess: (user) {
          appUserCubit.updateUser(user);
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc(updateUserProfile: serviceLocator()),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          final currentUser = context.read<AppUserCubit>().state.currentUser;
          return CustomDraggableSheet(
            initialChildSize: 0.6,
            footer: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  horizontal:
                      BorderSide(color: CustomColors.containerBorderSlate),
                ),
              ),
              child: CustomButton(
                isLoading: state.updateUserResult is ApiResultLoading,
                height: 42,
                onPressed: () {
                  _handleSubmit(context);
                },
                child: const Text("Save Changes"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SingleImagePicker(
                      previewImageUrl: currentUser?.profileImageUrl,
                      onFileChanged: (file) {
                        setState(() {
                          selectedImageFile = file;
                        });
                      },
                    ),
                  ),
                  20.kH,
                  const Text(
                    "Your profile",
                    style: CustomFonts.titleLarge,
                  ),
                  6.kH,
                  const Text(
                    "The information you share will be used across this platform to help other donors and fundraisers get to know you.",
                    style: CustomFonts.bodyMedium,
                  ),
                  20.kH,
                  CustomOutlinedTextfield(
                    label: "My full name",
                    controller: fullNameController,
                  ),
                  12.kH,
                  CustomOutlinedTextfield(
                    label: "My email (Read only)",
                    readOnly: true,
                    initialValue: currentUser?.email,
                  ),
                  12.kH,
                  CustomOutlinedTextfield(
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    label: "Phone number",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/images/malaysia-flag.png"),
                          4.kW,
                          const Text(
                            "+60",
                            style: CustomFonts.labelSmall,
                          )
                        ],
                      ),
                    ),
                    inputFormatters: [PhoneInputFormatter()],
                    keyboardType: TextInputType.phone,
                  ),
                  20.kH,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
