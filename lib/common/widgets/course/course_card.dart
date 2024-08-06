import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_outlined_icon_button.dart';
import 'package:education_app/common/widgets/container/tag.dart';
import 'package:education_app/common/widgets/course/course_favourite_button.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/user/user_favourite_course.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_bloc.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_event.dart';
import 'package:education_app/state_management/user_favourite_course/user_favourite_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onPressed;
  const CourseCard({
    super.key,
    required this.course,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: constraints.maxHeight,
            maxWidth: 207,
          ),
          child: InkWell(
            onTap: onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image
                Stack(
                  children: [
                    SizedBox(
                      width: 207,
                      height: 184,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: CachedNetworkImage(
                          imageUrl: course.thumbnailUrl ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              'assets/images/course-sample-image.png',
                            );
                          },
                        ),
                      ),
                    ),
                    CourseFavouriteButton(course: course,),
                  ],
                ),
                6.kH,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: CustomFonts.labelMedium,
                        maxLines: 2,
                      ),
                      4.kH,
                      Text(
                        'by ${course.instructor.instructorProfile?.fullName ?? course.instructor.fullName}',
                        style: CustomFonts.labelSmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                      8.kH,
                      ReviewStar(
                        review: course.reviewRating == null
                            ? 4.0
                            : course.reviewRating!,
                      ),
                      8.kH,
                      CustomTag.blue(
                        child: Text(
                          course.category.title,
                          style: CustomFonts.labelSmall
                              .copyWith(color: CustomColors.accentBlue),
                        ),
                      ),
                      8.kH,
                      Text(
                        course.displayPrice,
                        style: CustomFonts.titleMedium,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ReviewStar extends StatelessWidget {
  final double review;
  final double starSize;
  const ReviewStar({
    super.key,
    this.review = 4,
    this.starSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.filled(5, 0).mapWithIndex((_, index) {
          return HeroIcon(
            HeroIcons.star,
            style: HeroIconStyle.mini,
            size: starSize,
            color: index + 1 <= review ? Color(0xFFFFE143) : Color(0xFFD7D7D7),
          );
        }).toList(),
        2.kW,
        Text(
          review.toString(),
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFD600),
            ),
          ),
        ),
      ],
    );
  }
}
