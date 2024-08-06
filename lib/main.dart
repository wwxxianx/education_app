import 'package:education_app/app_router.dart';
import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/common/theme/app_theme.dart';
import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/common/widgets/dropdown_menu/language_dropdown_menu.dart';
import 'package:education_app/common/widgets/dropdown_menu/level_dropdown_menu.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/explore/explore_bloc.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_bloc.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Stripe.publishableKey = Constants.stripePublishableKey;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<ExploreBloc>()),
        BlocProvider(create: (_) => serviceLocator<LanguageCubit>()..fetchLanguages()),
        BlocProvider(create: (_) => serviceLocator<CourseCategoriesCubit>()..fetchCourseCategories()),
        BlocProvider(create: (_) => serviceLocator<CourseLevelCubit>()..fetchCourseLevels()),
        BlocProvider(create: (_) => serviceLocator<UserFavouriteCourseBloc>()..add(OnFetchUserFavouriteCourses())),
        // BlocProvider(create: (_) => serviceLocator<SignUpBloc>()),
        // BlocProvider(
        //     create: (_) =>
        //         ExploreCampaignsBloc(fetchCampaigns: serviceLocator())),
        // BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
        // BlocProvider(create: (_) => serviceLocator<GiftCardBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'Crowdfunding App',
        theme: appTheme,
        // home: SplashScreen(),
        routerConfig: AppRouter.router,
        // home: BlocBuilder<AppUserCubit, AppUserState>(
        //   builder: (context, state) {
        //     if (state is AppUserInitial) {
        //       return const LoginScreen();
        //     }
        //     if (state is AppUserLoggedIn) {
        //       if (state.user.isOnboardingCompleted) {
        //         return const NavigationScreen();
        //       }
        //       return const LoginScreen();
        //     }
        //     return const SizedBox();
        //   },
        // ),
      ),
    );
  }
}