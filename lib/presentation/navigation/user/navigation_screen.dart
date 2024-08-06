import 'package:education_app/common/theme/color.dart';
import 'package:education_app/presentation/navigation/user/bottom_nav_bar.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/app_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class UserNavigationScreen extends StatefulWidget {
  final Widget child;
  const UserNavigationScreen({
    super.key,
    required this.child,
  });

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final AppUserCubit appUserCubit = BlocProvider.of<AppUserCubit>(context);
    appUserCubit.listenToRealtimeNotification();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listenWhen: (previous, current) {
        return (previous.realtimeNotification !=
                current.realtimeNotification) &&
            current.realtimeNotification != null;
      },
      listener: (context, state) {
        final realtimeNotification = state.realtimeNotification;
        if (realtimeNotification == null) {
          return;
        }
        toastification.show(
          title: Text(realtimeNotification.title),
          description: Text(realtimeNotification.description ??
              'Check out your notification inbox'),
          applyBlurEffect: true,
          boxShadow: lowModeShadow,
          icon: const HeroIcon(
            HeroIcons.bellAlert,
            color: CustomColors.primaryBlue,
          ),
          autoCloseDuration: const Duration(seconds: 8),
          showProgressBar: true,
        );
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: const HomeBottomNavigationBar(),
          body: widget.child,
        ),
      ),
    );
  }
}
