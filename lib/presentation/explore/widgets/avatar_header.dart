import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarHeader extends StatelessWidget {
  final String title;
  final Widget? action;
  final EdgeInsetsGeometry padding;
  const AvatarHeader({
    super.key,
    required this.title,
    this.action,
    this.padding = const EdgeInsets.only(
      left: Dimensions.screenHorizontalPadding,
      right: Dimensions.screenHorizontalPadding,
      top: 20.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      
      builder: (context, state) {
        return Padding(
          padding: padding,
          child: Row(
            children: [
              if (state.currentUser != null)
                Avatar(
                  imageUrl: state.currentUser!.profileImageUrl,
                  placeholder: state.currentUser!.fullName[0],
                ),
              8.kW,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomFonts.titleSmall,
                  ),
                  if (state.currentUser != null)
                    Text(
                      state.currentUser!.fullName,
                      style: CustomFonts.labelSmall
                          .copyWith(color: CustomColors.textGrey),
                    ),
                ],
              ),
              const Spacer(),
              action ?? SizedBox(),
            ],
          ),
        );
      },
    );
  }
}