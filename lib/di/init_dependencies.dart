import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/dio.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/data/repository/auth/auth_repository_impl.dart';
import 'package:education_app/data/repository/constant/constant_repository_impl.dart';
import 'package:education_app/data/repository/course/course_repository_impl.dart';
import 'package:education_app/data/repository/user/user_repository_impl.dart';
import 'package:education_app/domain/repository/auth/auth_repository.dart';
import 'package:education_app/domain/repository/constant/constant_repository.dart';
import 'package:education_app/domain/repository/course/course_repository.dart';
import 'package:education_app/domain/repository/user/user_repository.dart';
import 'package:education_app/domain/usecases/auth/get_current_user.dart';
import 'package:education_app/domain/usecases/auth/login.dart';
import 'package:education_app/domain/usecases/auth/sign_out.dart';
import 'package:education_app/domain/usecases/auth/sign_up.dart';
import 'package:education_app/domain/usecases/constant/fetch_languages.dart';
import 'package:education_app/domain/usecases/course/create_course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_levels.dart';
import 'package:education_app/domain/usecases/course/fetch_courses.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/domain/usecases/course_category/fetch_all_course_categories.dart';
import 'package:education_app/domain/usecases/user/update_user_profile.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
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
}

void _initCore() {
  serviceLocator
    ..registerLazySingleton(
        () => AppUserCubit(getCurrentUser: serviceLocator()))
    ..registerLazySingleton(() => DioNetwork.provideDio())
    ..registerLazySingleton(() => MySharedPreference())
    ..registerLazySingleton(() => RestClient(serviceLocator()));
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
    // Usecase
    ..registerLazySingleton(() => SignUp(serviceLocator()))
    ..registerLazySingleton(() => SignOut(serviceLocator()))
    ..registerLazySingleton(() => Login(authRepository: serviceLocator()))
    ..registerLazySingleton(
        () => UpdateUserProfile(userRepository: serviceLocator()))
    ..registerLazySingleton(() => GetCurrentUser(serviceLocator()));
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
    // Usecases
    ..registerFactory(
        () => FetchAllCourseCategories(courseRepository: serviceLocator()))
    ..registerFactory(() => FetchCourses(courseRepository: serviceLocator()))
    ..registerFactory(() => FetchCourse(courseRepository: serviceLocator()))
    ..registerFactory(() => CreateCourse(courseRepository: serviceLocator()));
}
