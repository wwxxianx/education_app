import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/common/widgets/container/tag.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/common/widgets/media/media_carousel.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/course_details/tabs/tab_view.dart';
import 'package:education_app/presentation/manage_course_details/tabs/tab_view.dart';
import 'package:education_app/presentation/manage_course_details/widgets/bottom_sheet_nav.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class ManageCourseDetailsScreen extends StatelessWidget {
  final String courseId;
  const ManageCourseDetailsScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageCourseDetailsBloc(fetchCourse: serviceLocator())
        ..add(OnFetchCourse(courseId)),
      child: BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
        builder: (context, state) {
          final courseResult = state.courseResult;
          return Scaffold(
            extendBodyBehindAppBar: true,
            bottomSheet: ManageCourseDetailsBottomNavSheet(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton.filledTonal(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white.withOpacity(0.87),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const HeroIcon(
                  HeroIcons.chevronLeft,
                  color: Colors.black,
                  size: 18.0,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: Dimensions.bottomActionBarHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (courseResult is ApiResultLoading)
                    Skeleton(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.75,
                    ),
                  if (courseResult is ApiResultSuccess<Course>)
                    MediaCarousel(
                      images: courseResult.data.images,
                      videoUrls: courseResult.data.videoUrl != null
                          ? [courseResult.data.videoUrl!]
                          : [],
                    ),
                  24.kH,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.screenHorizontalPadding,
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (courseResult is ApiResultLoading)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Skeleton(
                                height: Dimensions.loadingTitleHeight,
                                width: double.maxFinite,
                              ),
                              4.kH,
                              const Skeleton(
                                height: Dimensions.loadingTitleHeight,
                                width: 200,
                              ),
                            ],
                          ),
                        if (courseResult is ApiResultSuccess<Course>)
                          Text(
                            courseResult.data.title,
                            style: CustomFonts.titleExtraLarge,
                          ),
                        6.kH,
                        if (courseResult is ApiResultLoading)
                          Skeleton(
                            width: 60,
                            height: 30,
                          ),
                        if (courseResult is ApiResultSuccess<Course>)
                          CustomTag.grey(
                            child: Text(
                                courseResult.data.category.title.capitalize()),
                          ),
                        12.kH,
                        if (courseResult is ApiResultSuccess<Course>)
                          ReviewStar(
                            review: courseResult.data.reviewRating ?? 4.0,
                          ),
                        12.kH,
                      ],
                    ),
                  ),
                  8.kH,
                  ManageCourseDetailsTabView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
