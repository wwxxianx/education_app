import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/account/account_screen.dart';
import 'package:education_app/presentation/account_favorite_course/favorite_course_screen.dart';
import 'package:education_app/presentation/account_preference/account_preference_screen.dart';
import 'package:education_app/presentation/account_preference/bloc/account_preference_bloc.dart';
import 'package:education_app/presentation/create_course/create_course_screen.dart';
import 'package:education_app/presentation/explore/explore_screen.dart';
import 'package:education_app/presentation/instructor_subscription/instructor_subscription_screen.dart';
import 'package:education_app/presentation/login/login_screen.dart';
import 'package:education_app/presentation/manage_course_details/manage_course_details_screen.dart';
import 'package:education_app/presentation/my_course/my_course_screen.dart';
import 'package:education_app/presentation/my_instructor_account/my_instructor_account_screen.dart';
import 'package:education_app/presentation/my_learning/my_learning_screen.dart';
import 'package:education_app/presentation/my_learning_details/my_learning_details_screen.dart';
import 'package:education_app/presentation/navigation/instructor/navigation_screen.dart';
import 'package:education_app/presentation/navigation/user/navigation_screen.dart';
import 'package:education_app/presentation/notification/notification_screen.dart';
import 'package:education_app/presentation/onboarding_instructor/instructor_onboarding_screen.dart';
import 'package:education_app/presentation/purchase/purchase_screen.dart';
import 'package:education_app/presentation/redirects/instructor_account_redirect_screen.dart';
import 'package:education_app/presentation/redirects/purchase_course_success_redirect_screen.dart';
import 'package:education_app/presentation/search/search_screen.dart';
import 'package:education_app/presentation/sign_up/sign_up_screen.dart';
import 'package:education_app/presentation/splash/splash_screen.dart';
import 'package:education_app/presentation/video_player/video_player_wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:education_app/presentation/onboarding/onboarding_screen.dart';
import 'package:education_app/presentation/course_details/course_details_screen.dart';
import 'package:education_app/presentation/bank_account/bank_account_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  // final GlobalKey<NavigatorState> _shellNavigatorKey =
  //     GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GlobalKey<NavigatorState> _instructorShellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'instructor-root');
  static final GlobalKey<NavigatorState> _userShellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'instructor-root');
  static GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/loading',
        routes: [
          ShellRoute(
            navigatorKey: _userShellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return UserNavigationScreen(
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: ExploreScreen.route,
                builder: (context, state) => const ExploreScreen(),
              ),
              GoRoute(
                path: SearchScreen.route,
                builder: (context, state) => const SearchScreen(),
              ),
              GoRoute(
                  parentNavigatorKey: _userShellNavigatorKey,
                  path: MyLearningScreen.route,
                  builder: (context, state) => const MyLearningScreen(),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: ":courseId",
                      builder: (context, state) {
                        final courseId = state.pathParameters['courseId'] ?? "";
                        final coursePart = state.extra as CoursePart?;
                        return MyLearningDetailsScreen(
                          courseId: courseId,
                          progressCoursePart: coursePart,
                        );
                      },
                    ),
                  ]),
              GoRoute(
                // parentNavigatorKey: _userShellNavigatorKey,
                path: AccountScreen.route,
                builder: (context, state) => const AccountScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'favorite',
                    builder: (context, state) => const FavoriteCourseScreen(),
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'preference',
                    builder: (context, state) => const AccountPreferencesScreen(),
                  ),
                ],
              ),
            ],
          ),
          ShellRoute(
            navigatorKey: _instructorShellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return InstructorNavigationScreen(
                child: child,
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _instructorShellNavigatorKey,
                path: MyCourseScreen.route,
                builder: (context, state) => const MyCourseScreen(),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: ':courseId',
                    builder: (context, state) {
                      final courseId = state.pathParameters['courseId'] ?? '';
                      return ManageCourseDetailsScreen(
                        courseId: courseId,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: "/bank",
                builder: (context, state) => const ConnectedBankAccountScreen(),
              ),
              GoRoute(
                path: InstructorSubscriptionScreen.route,
                builder: (context, state) =>
                    const InstructorSubscriptionScreen(),
              ),
              GoRoute(
                path: "/my-instructor-profile",
                builder: (context, state) => const MyInstructorAccountScreen(),
              ),
            ],
          ),
          GoRoute(
            path: InstructorRedirectScreen.route,
            builder: (context, state) => const InstructorRedirectScreen(), //
          ),
          GoRoute(
            path: PurchaseCourseSuccessRedirectScreen.route,
            builder: (context, state) => const PurchaseCourseSuccessRedirectScreen(), //
          ),
          GoRoute(
            path: NotificationScreen.route,
            builder: (context, state) => const NotificationScreen(), //
          ),
          GoRoute(
            path: InstructorOnboardingScreen.route,
            builder: (context, state) => const InstructorOnboardingScreen(), //
          ),
          GoRoute(
            path: '/loading',
            builder: (context, state) => const SplashScreen(), //
          ),
          GoRoute(
            path: LoginScreen.route,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: SignUpScreen.route,
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            path: OnboardingScreen.route,
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
              path: CourseDetailsScreen.route,
              builder: (context, state) {
                final courseId = state.pathParameters['courseId'] ?? '';
                return CourseDetailsScreen(courseId: courseId);
              },
              routes: [
                GoRoute(
                  path: 'purchase',
                  builder: (context, state) {
                    final courseId = state.pathParameters['courseId'] ?? '';
                    return PurchaseScreen(courseId: courseId);
                  },
                )
              ]),
          GoRoute(
            path: CreateCourseScreen.route,
            builder: (context, state) => const CreateCourseScreen(),
          ),
          GoRoute(
            path: VideoPlayerWrapperScreen.route,
            builder: (context, state) {
              final videoUrl = state.extra as String? ?? '';
              return VideoPlayerWrapperScreen(videoUrl: videoUrl);
            },
          ),
        ],
      );
}
