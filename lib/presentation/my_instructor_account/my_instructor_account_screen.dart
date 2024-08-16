import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/user/instructor_profile.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_bloc.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_event.dart';
import 'package:education_app/state_management/my_instructor_account/my_instructor_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyInstructorAccountScreen extends StatelessWidget {
  const MyInstructorAccountScreen({super.key});

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
        return MyInstructorAccountBloc(fetchInstructorProfile: serviceLocator())
          ..add(OnFetchInstructorProfile(userId: ''));
      },
      child: Scaffold(
        body: BlocBuilder<MyInstructorAccountBloc, MyInstructorAccountState>(
          builder: (context, state) {
            final instructorProfileResult = state.instructorProfileResult;
            if (instructorProfileResult
                is ApiResultSuccess<InstructorProfile>) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.screenHorizontalPadding, vertical: 20,),
                child: Center(
                  child: InstructorProfileItem(
                    profile: instructorProfileResult.data,
                  ),
                ),
              );
            }
            if (state.isInstructorProfileNull) {
              return Text('NULL');
            }
            if (instructorProfileResult
                is ApiResultFailure<InstructorProfile>) {
              return Text("Error");
            }
            return Text("Loading...");
          },
        ),
      ),
    );
  }
}

class InstructorProfileItem extends StatelessWidget {
  final InstructorProfile profile;
  const InstructorProfileItem({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Avatar(
          imageUrl: profile.profileImageUrl,
          placeholder: profile.fullName[0],
          size: 120,
        ),
        16.kH,
        Text(
          profile.fullName,
          style: CustomFonts.labelMedium,
        ),
        20.kH,
        TextButton(
          onPressed: () {
            context.go("/explore");
          },
          child: const Text("Switch to student view"),
        ),
      ],
    );
  }
}
