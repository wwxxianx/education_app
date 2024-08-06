import 'package:education_app/common/theme/color.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_bloc.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_event.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class CourseFavouriteButton extends StatelessWidget {
  final Course course;
  const CourseFavouriteButton({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFavouriteCourseBloc, UserFavouriteCourseState>(
      builder: (context, state) {
        final favouriteCoursesResult = state.favouriteCoursesResult;
        if (favouriteCoursesResult
            is ApiResultSuccess<List<UserFavouriteCourse>>) {
          final isFavourite = favouriteCoursesResult.data
              .any((favouriteCourse) => favouriteCourse.courseId == course.id);
          return IconButton.filledTonal(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0.66))),
            onPressed: () {
              context
                  .read<UserFavouriteCourseBloc>()
                  .add(OnUpdateUserFavouriteCourse(courseId: course.id));
            },
            icon: state.updateResult is ApiResultLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: CustomColors.primaryBlue,
                    ),
                  )
                : HeroIcon(
                    HeroIcons.bookmark,
                    style: isFavourite
                        ? HeroIconStyle.solid
                        : HeroIconStyle.outline,
                    size: 20,
                  ),
          );
        }
        return IconButton.filledTonal(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.white.withOpacity(0.66))),
          onPressed: () {},
          icon: const CircularProgressIndicator(
            strokeWidth: 2,
            color: CustomColors.primaryBlue,
          ),
        );
      },
    );
  }
}
