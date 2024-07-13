import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/user/user_profile_payload.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/presentation/explore/explore_screen.dart';
import 'package:education_app/presentation/onboarding/widgets/onboarding_progress_bar.dart';
import 'package:education_app/state_management/onboarding/onboarding_bloc.dart';
import 'package:education_app/state_management/onboarding/onboarding_event.dart';
import 'package:education_app/state_management/onboarding/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  static const route = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _handlePageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _handleNextPage() {
    setState(() {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  void _handlePreviousPage() {
    setState(() {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(updateUserProfile: serviceLocator()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: Dimensions.screenHorizontalPadding,
            right: Dimensions.screenHorizontalPadding,
            top: MediaQuery.of(context).viewPadding.top + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pregress bar
              OnboardingProgressBar(
                currentStep: currentPage,
                totalStep: 3,
              ),
              24.kH,
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: _handlePageChange,
                  children: [
                    OnboardingPageOne(
                      onNextPage: _handleNextPage,
                    ),
                    OnboardingPageTwo(
                      onNextPage: _handleNextPage,
                      onPreviousPage: _handlePreviousPage,
                    ),
                    const OnboardingPreferencePage(),
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

class OnboardingPreferencePage extends StatelessWidget {
  const OnboardingPreferencePage({super.key});

  void _handleSubmit(BuildContext context) {
    final payload = UserProfilePayload(
        fullName: null, isOnBoardingCompleted: true, profileImageFile: null);
    context.read<OnboardingBloc>().add(
          CompleteOnboarding(
            payload: payload,
            onSuccess: () {
              context.go(ExploreScreen.route);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let us help you to find what\nyou need to learn!",
              style: CustomFonts.titleLarge,
            ),
            2.kH,
            Text(
              "Tell us what are you interested in.",
              style: CustomFonts.labelMedium
                  .copyWith(color: CustomColors.textGrey),
            ),
            20.kH,
            CourseCategoryList(
              onPressed: (category) {},
              selectedCategoryIds: ['1'],
            ),
            24.kH,
            SizedBox(
              width: double.maxFinite,
              child: CustomButton(
                isLoading: state.updateUserResult is ApiResultLoading,
                enabled: state.updateUserResult is! ApiResultLoading,
                style: CustomButtonStyle.secondaryBlue,
                onPressed: () {
                  _handleSubmit(context);
                },
                child: Text("Do it later"),
              ),
            ),
            8.kH,
            SizedBox(
              width: double.maxFinite,
              child: CustomButton(
                isLoading: state.updateUserResult is ApiResultLoading,
                enabled: state.updateUserResult is! ApiResultLoading,
                style: CustomButtonStyle.secondaryBlue,
                onPressed: () {},
                child: Text("Let's start"),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OnboardingPageOne extends StatelessWidget {
  final VoidCallback onNextPage;
  const OnboardingPageOne({
    super.key,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kH,
        Image.asset("assets/images/onboarding-illustration-1.png"),
        20.kH,
        const Text(
          "Better way to learning\nis calling you!",
          textAlign: TextAlign.center,
          style: CustomFonts.titleExtraLarge,
        ),
        20.kH,
        SizedBox(
          width: 200,
          child: CustomButton(
            onPressed: onNextPage,
            child: Text("Next"),
          ),
        ),
      ],
    );
  }
}

class OnboardingPageTwo extends StatelessWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const OnboardingPageTwo({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kH,
        Image.asset("assets/images/onboarding-illustration-2.png"),
        20.kH,
        Text("All courses you need!"),
        20.kH,
        SizedBox(
          width: 200,
          child: CustomButton(
            onPressed: onNextPage,
            child: Text("Next"),
          ),
        ),
      ],
    );
  }
}
