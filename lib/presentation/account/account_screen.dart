import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/button/custom_list_tile.dart';
import 'package:education_app/common/widgets/text/text_bg_gradient_shape.dart';
import 'package:education_app/presentation/account/widgets/account_section_card.dart';
import 'package:education_app/presentation/account/widgets/edit_account_bottom_sheet.dart';
import 'package:education_app/presentation/redirects/instructor_account_redirect_screen.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class AccountScreen extends StatelessWidget {
  static const route = '/account';
  const AccountScreen({super.key});

  void _handleSignOut(BuildContext context) {
    context.read<AppUserCubit>().signOut(onSuccess: () {
      context.go('/login');
    });
  }

  void _showEditAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return const EditAccountBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AppUserCubit>().state.currentUser;
    if (currentUser == null) {
      return Scaffold(
        body: Center(child: Column()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar header
              20.kH,
              Row(
                children: [
                  Avatar(
                    imageUrl: currentUser.profileImageUrl,
                    placeholder: currentUser.fullName[0],
                    size: 64,
                  ),
                  8.kW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            currentUser.fullName,
                            style: CustomFonts.labelLarge,
                          ),
                          4.kW,
                          const HeroIcon(
                            HeroIcons.checkBadge,
                            size: 20,
                            color: CustomColors.accentGreen,
                            style: HeroIconStyle.solid,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _showEditAccountBottomSheet(context);
                        },
                        child: const Text(
                          "Edit my account",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              24.kH,
              AccountSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWithGradientBGShape(
                      text: Text(
                        "My Activity",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 80,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {
                        context.push('/account/favorite');
                      },
                      leading: SvgPicture.asset("assets/icons/hearts.svg"),
                      title: const Text(
                        "Saved",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: const HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    )
                  ],
                ),
              ),
              20.kH,
              AccountSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWithGradientBGShape(
                      text: Text(
                        "Instructor",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 90,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {
                        context.push(InstructorRedirectScreen.route);
                      },
                      leading: SvgPicture.asset(
                          "assets/icons/blackboard-filled.svg"),
                      title: const Text(
                        "Instructor",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: const HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              20.kH,
              AccountSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWithGradientBGShape(
                      text: Text(
                        "My Account",
                        style: CustomFonts.titleMedium,
                      ),
                      width: 90,
                    ),
                    4.kH,
                    CustomListTile(
                      onTap: () {
                        context.push('/account/preference');
                      },
                      leading: SvgPicture.asset("assets/icons/smile-heart.svg"),
                      title: const Text(
                        "My Preference",
                        style: CustomFonts.labelSmall,
                      ),
                      trailing: const HeroIcon(
                        HeroIcons.chevronRight,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              24.kH,
              CustomButton(
                style: CustomButtonStyle.white,
                onPressed: () {
                  _handleSignOut(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeroIcon(
                      HeroIcons.arrowLeftOnRectangle,
                      size: 16,
                      style: HeroIconStyle.mini,
                    ),
                    4.kW,
                    const Text(
                      "Sign out",
                      style: CustomFonts.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
