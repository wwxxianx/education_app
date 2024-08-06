import 'package:education_app/common/widgets/course/course_category_toggle_list.dart';
import 'package:education_app/common/widgets/dropdown_menu/language_dropdown_menu.dart';
import 'package:education_app/common/widgets/dropdown_menu/level_dropdown_menu.dart';
import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/dio.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/data/repository/auth/auth_repository_impl.dart';
import 'package:education_app/data/repository/constant/constant_repository_impl.dart';
import 'package:education_app/data/repository/course/course_repository_impl.dart';
import 'package:education_app/data/repository/user/user_repository_impl.dart';
import 'package:education_app/data/service/payment/payment_service.dart';
import 'package:education_app/domain/repository/auth/auth_repository.dart';
import 'package:education_app/domain/repository/constant/constant_repository.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:education_app/domain/usecases/auth/get_current_user.dart';
import 'package:education_app/domain/usecases/auth/login.dart';
import 'package:education_app/domain/usecases/auth/sign_out.dart';
import 'package:education_app/domain/usecases/auth/sign_up.dart';
import 'package:education_app/domain/usecases/constant/fetch_languages.dart';
import 'package:education_app/domain/usecases/course/craete_course_voucher.dart';
import 'package:education_app/domain/usecases/course/create_course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_faq.dart';
import 'package:education_app/domain/usecases/course/fetch_course_levels.dart';
import 'package:education_app/domain/usecases/course/fetch_course_vouchers.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/domain/usecases/course/update_course.dart';
import 'package:education_app/domain/usecases/course/update_course_faq.dart';
import 'package:education_app/domain/usecases/course_category/fetch_all_course_categories.dart';
import 'package:education_app/domain/usecases/notification/fetch_notifications.dart';
import 'package:education_app/domain/usecases/notification/read_notification.dart';
import 'package:education_app/domain/usecases/payment/connect_account.dart';
import 'package:education_app/domain/usecases/payment/fetch_connected_account.dart';
import 'package:education_app/domain/usecases/payment/update_connect_account.dart';
import 'package:education_app/domain/usecases/user/claim_voucher.dart';
import 'package:education_app/domain/usecases/user/create_instructor_profile.dart';
import 'package:education_app/domain/usecases/user/fetch_favourite_courses.dart';
import 'package:education_app/domain/usecases/user/fetch_instructor_profile.dart';
import 'package:education_app/domain/usecases/user/fetch_learning_courses.dart';
import 'package:education_app/domain/usecases/user/fetch_my_vouchers.dart';
import 'package:education_app/domain/usecases/user/update_favourite_course.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/domain/usecases/user/fetch_learning_course.dart';
import 'package:education_app/state_management/explore/explore_bloc.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: "https://vooexvblyikqqqacbwnx.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZvb2V4dmJseWlrcXFxYWNid254Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTczMzcyMzksImV4cCI6MjAzMjkxMzIzOX0.gJOJHUkZoQiVURe4_CPd4GJF1Eww1adR1f41DgunN-c",
  );

  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  _initCore();
  _initCourse();
  _initConstant();
  _initUserAndAuth();
  _initPayment();
}

void _initPayment() {
  serviceLocator
    // Service
    ..registerFactory(() => PaymentService(api: serviceLocator()))
    // Usecases
    ..registerLazySingleton(
        () => FetchConnectedAccount(paymentService: serviceLocator()))
    ..registerLazySingleton(
        () => UpdateConnectAccount(paymentService: serviceLocator()))
    ..registerFactory(() => ConnectAccount(paymentService: serviceLocator()));
}

void _initCore() {
  serviceLocator
    ..registerLazySingleton(() => AppUserCubit(
          getCurrentUser: serviceLocator(),
          fetchMyVouchers: serviceLocator(),
          fetchNotifications: serviceLocator(),
          toggleReadNotification: serviceLocator(),
          supabase: serviceLocator(),
          signOut: serviceLocator(),
        ))
    ..registerLazySingleton(() => DioNetwork.provideDio())
    ..registerLazySingleton(() => MySharedPreference())
    ..registerLazySingleton(() => RestClient(serviceLocator()))
    ..registerLazySingleton(
        () => LanguageCubit(fetchLanguages: serviceLocator()))
    ..registerLazySingleton(
        () => CourseCategoriesCubit(fetchAllCourseCategories: serviceLocator()))
    ..registerLazySingleton(
        () => CourseLevelCubit(fetchCourseLevels: serviceLocator()));
}

void _initUserAndAuth() {
  serviceLocator
    // Repo
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        supabase: serviceLocator(),
        api: serviceLocator(),
        sp: serviceLocator()))
    ..registerFactory<UserRepository>(
        () => UserRepositoryImpl(api: serviceLocator(), sp: serviceLocator()))
    // Bloc
    ..registerLazySingleton(() => UserFavouriteCourseBloc(
        fetchFavouriteCourses: serviceLocator(),
        updateFavouriteCourse: serviceLocator()))
    // Usecase
    ..registerLazySingleton(() => SignUp(serviceLocator()))
    ..registerLazySingleton(() => SignOut(serviceLocator()))
    ..registerLazySingleton(() => Login(authRepository: serviceLocator()))
    ..registerLazySingleton(
        () => UpdateUserProfile(userRepository: serviceLocator()))
    ..registerLazySingleton(() => GetCurrentUser(serviceLocator()))
    ..registerLazySingleton(
        () => FetchInstructorProfile(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => CreateInstructorProfile(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => FetchMyVouchers(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => FetchLearningCourses(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => FetchLearningCourse(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => FetchFavouriteCourses(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => UpdateFavouriteCourse(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => FetchNotifications(userRepository: serviceLocator()))
    ..registerLazySingleton(
        () => ToggleReadNotification(userRepository: serviceLocator()));
}

void _initConstant() {
  serviceLocator
    // Repo
    ..registerFactory<ConstantRepository>(
        () => ConstantRepositoryImpl(api: serviceLocator()))
    // Usecases
    ..registerFactory(
        () => FetchLanguages(constantRepository: serviceLocator()))
    ..registerFactory(
        () => FetchCourseLevels(courseRepository: serviceLocator()));
}

void _initCourse() {
  serviceLocator
    // Repo
    ..registerFactory<CourseRepository>(() => CourseRepositoryImpl(
          supabase: serviceLocator(),
          sp: serviceLocator(),
          api: serviceLocator(),
        ))
    // Bloc
    ..registerLazySingleton(() => ExploreBloc(fetchCourses: serviceLocator()))
    // Usecases
    ..registerFactory(
        () => FetchAllCourseCategories(courseRepository: serviceLocator()))
    ..registerFactory(() => FetchCourses(courseRepository: serviceLocator()))
    ..registerFactory(() => FetchCourse(courseRepository: serviceLocator()))
    ..registerFactory(() => CreateCourse(courseRepository: serviceLocator()))
    ..registerFactory(() => UpdateCourse(courseRepository: serviceLocator()))
    ..registerFactory(() => FetchCourseFAQ(courseRepository: serviceLocator()))
    ..registerFactory(() => UpdateCourseFAQ(courseRepository: serviceLocator()))
    ..registerFactory(
        () => FetchCourseVouchers(courseRepository: serviceLocator()))
    ..registerFactory(
        () => CreateCourseVoucher(courseRepository: serviceLocator()))
    ..registerFactory(
        () => ClaimVoucher(courseRepository: serviceLocator()));
}
