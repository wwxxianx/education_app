import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/presentation/account_preference/bloc/account_preference_bloc.dart';
import 'package:education_app/presentation/account_preference/bloc/account_preference_event.dart';
import 'package:education_app/presentation/account_preference/bloc/account_preference_state.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPreferencesScreen extends StatelessWidget {
  static const route = '/preference';
  const AccountPreferencesScreen({super.key});

  void _handleSubmit(BuildContext context) {
    final appUserCubit = context.read<AppUserCubit>();
    context.read<AccountPreferencesBloc>().add(
      OnUpdateUser(
        onSuccess: (user) {
          // Update app user state
          appUserCubit.updateUser(user);
        },
      ),
    );
  }

  void _handleSelectCategory(BuildContext context, String categoryId) {
    context
        .read<AccountPreferencesBloc>()
        .add(OnSelectCategory(id: categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final currentUser = context.read<AppUserCubit>().state.currentUser;
        return AccountPreferencesBloc(updateUserProfile: serviceLocator())
          ..add(OnInitSelectedCategoryIds(currentUser: currentUser));
      },
      child: BlocBuilder<AccountPreferencesBloc, AccountPreferencesState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/smile-heart.svg"),
                  4.kW,
                  const Text(
                    "My Preferences",
                    style: CustomFonts.labelMedium,
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.all(Dimensions.screenHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tell us what are you interested in.",
                      style: CustomFonts.titleLarge,
                    ),
                    4.kH,
                    Text(
                      'We will recommend courses based on your choice.',
                      style: CustomFonts.bodyMedium.copyWith(
                        color: CustomColors.textGrey,
                      ),
                    ),
                    12.kH,
                    CourseCategoryList(
                      onPressed: (category) {
                        _handleSelectCategory(context, category.id);
                      },
                      selectedCategoryIds: state.selectedCategoryIds,
                    ),
                    // const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            isLoading:
                                state.updateUserResult is ApiResultLoading,
                            enabled:
                                state.updateUserResult is! ApiResultLoading,
                            onPressed: () {
                              _handleSubmit(context);
                            },
                            child: const Text("Save"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
