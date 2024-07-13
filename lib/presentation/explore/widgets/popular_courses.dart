import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/course_details/course_details_screen.dart';
import 'package:education_app/presentation/video_player/video_player_wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopularCourses extends StatelessWidget {
  const PopularCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: Dimensions.screenHorizontalPadding),
          child: Text(
            "Popular Course Match\nwith Your Interest",
            style: CustomFonts.labelLarge,
          ),
        ),
        12.kH,
        SizedBox(
          height: 450,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: Course.samples.length,
              itemBuilder: (context, index) {
                return Container(
                  key: ValueKey(Course.samples[index].id),
                  margin: EdgeInsets.only(
                    right: 16,
                    left: index == 0 ? Dimensions.screenHorizontalPadding : 0.0,
                  ),
                  child: CourseCard(
                    onPressed: () {
                      context.push(VideoPlayerWrapperScreen.route,
                          extra:
                              'https://vooexvblyikqqqacbwnx.supabase.co/storage/v1/object/public/course/videos/6646688-hd_1920_1080_24fps__1_.mp4');
                    },
                    course: Course.samples[index],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
