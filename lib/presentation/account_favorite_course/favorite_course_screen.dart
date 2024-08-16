import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/course/course_list_tile.dart';
import 'package:education_app/common/widgets/empty_illustration.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_bloc.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_event.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

class FavoriteCourseScreen extends StatelessWidget {
  const FavoriteCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorite"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => UserFavouriteCourseBloc(
          fetchFavouriteCourses: serviceLocator(),
          updateFavouriteCourse: serviceLocator(),
        )..add(OnFetchUserFavouriteCourses()),
        child: BlocConsumer<UserFavouriteCourseBloc, UserFavouriteCourseState>(
          listener: (context, state) {
            final favouriteCoursesResult = state.favouriteCoursesResult;
            if (favouriteCoursesResult
                is ApiResultFailure<List<UserFavouriteCourse>>) {
              // Error
              toastification.show(
                type: ToastificationType.error,
                title: Text(favouriteCoursesResult.errorMessage ??
                    "Something went wrong"),
              );
            }
          },
          builder: (context, state) {
            final favouriteCoursesResult = state.favouriteCoursesResult;
            if (favouriteCoursesResult is ApiResultLoading ||
                favouriteCoursesResult
                    is ApiResultFailure<List<UserFavouriteCourse>>) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (favouriteCoursesResult
                is ApiResultSuccess<List<UserFavouriteCourse>>) {
              if (favouriteCoursesResult.data.isEmpty) {
                // Empty
                return const EmptyIllustration(
                  title:
                      "Seems like you haven't add any course to your favorite list",
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.screenHorizontalPadding),
                itemCount: favouriteCoursesResult.data.length,
                itemBuilder: (context, index) {
                  final favorite = favouriteCoursesResult.data[index];
                  return CourseListTile(course: favorite.course);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
