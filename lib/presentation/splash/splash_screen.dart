import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/presentation/explore/explore_screen.dart';
import 'package:education_app/presentation/onboarding/onboarding_screen.dart';
import 'package:education_app/presentation/splash/splash_bg_shape.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> textPositionAnimation;
  late Animation<double> textOpacityAnimation;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 9.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    textPositionAnimation = Tween<double>(begin: -60, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    _navigateAfterDelay();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _navigateAfterDelay() async {
    String destination;
    final appUserCubit = context.read<AppUserCubit>();
    await appUserCubit.checkUserLoggedIn();
    final state = appUserCubit.state;
    Future.delayed(const Duration(milliseconds: 300), () {
      animationController.forward().then((value) {
        if (state.currentUser != null) {
          if (state.currentUser?.isOnboardingCompleted ?? false) {
            destination = ExploreScreen.route;
          } else {
            destination = OnboardingScreen.route;
          }
        } else {
          destination = '/login';
        }

        if (mounted) {
          context.go(destination);
        }
      });
    });

    if (!mounted) return;
    // if (state.currentUser != null) {
    //   // Init app state
    //   context.read<GiftCardBloc>().add(OnFetchAllGiftCards());
    //   context.read<AppUserCubit>().fetchNotifications();
    //   context.read<HomeBloc>().add(OnFetchRecommendedCampaigns());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimation.value,
                  child: Container(
                    child: CustomPaint(
                      size: Size(
                          229,
                          (229 * 0.9781659388646288)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: SplashBgShapePainter(),
                    ),
                  ),
                );
              },
            ),
            // Positioned(
            //   bottom: -100,
            //   right: -120,
            //   child: Transform.scale(
            //     scale: 1.05,
            //     child: Lottie.asset(
            //       "assets/animations/splash-anim.json",
            //       height: 200,
            //       width: 200,
            //     ),
            //   ),
            // ),
            // LottieBuilder.asset(
            //     "assets/animations/Animation - 1720333417882.json"),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Positioned(
                  bottom: textPositionAnimation.value,
                  child: Opacity(
                    opacity: textOpacityAnimation.value,
                    child: Text(
                      "Welcome Back!",
                      style: CustomFonts.titleExtraLarge,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
