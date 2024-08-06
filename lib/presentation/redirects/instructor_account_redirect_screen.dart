import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/presentation/my_course/my_course_screen.dart';
import 'package:education_app/presentation/onboarding_instructor/instructor_onboarding_screen.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_bloc.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_event.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class InstructorRedirectScreen extends StatelessWidget {
  static const route = "/instructor-redirect";
  const InstructorRedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final appUserState = context.read<AppUserCubit>().state;
        if (appUserState.currentUser != null) {
          return MyInstructorAccountBloc(
              fetchInstructorProfile: serviceLocator())
            ..add(
                OnFetchInstructorProfile(userId: appUserState.currentUser!.id));
        }
        return MyInstructorAccountBloc(
            fetchInstructorProfile: serviceLocator());
      },
      child: BlocConsumer<MyInstructorAccountBloc, MyInstructorAccountState>(
        listener: (context, state) {
          final instructorProfileResult = state.instructorProfileResult;
          if (instructorProfileResult is ApiResultSuccess<InstructorProfile>) {
            context.pushReplacement(MyCourseScreen.route);
          }
          if (state.isInstructorProfileNull) {
            context.pushReplacement(InstructorOnboardingScreen.route);
          }
          if (instructorProfileResult is ApiResultFailure<InstructorProfile>) {
            context.pop();
            toastification.show(
              title: const Text(
                  "Function unavailable now. Please try again later"),
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
