import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/utils/show_snackbar.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/common/widgets/container/tag.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/common/widgets/media/media_carousel.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/presentation/manage_course_details/tabs/tab_view.dart';
import 'package:education_app/presentation/manage_course_details/widgets/before_content.dart';
import 'package:education_app/presentation/manage_course_details/widgets/bottom_sheet_nav.dart';
import 'package:education_app/presentation/manage_course_details/widgets/edit_details_bottom_sheet.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class ManageCourseDetailsScreen extends StatelessWidget {
  final String courseId;
  const ManageCourseDetailsScreen({
    super.key,
    required this.courseId,
  });

  Widget _buildContent(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return ManageCourseDetailsSuccessContent(courseId: courseId);
    }
    if (courseResult is ApiResultLoading) {
      return ManageCourseDetailsLoadingContent();
    }
    if (courseResult is ApiResultFailure<Course>) {
      return ManageCourseDetailsSuccessContent(
        courseId: courseId,
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageCourseDetailsBloc(
        fetchCourse: serviceLocator(),
        updateCourse: serviceLocator(),
        fetchCourseFAQ: serviceLocator(),
        updateCourseFAQ: serviceLocator(),
        createCourseVoucher: serviceLocator(),
        fetchCourseVouchers: serviceLocator(),
        updateCourseSection: serviceLocator(),
        createCoursePart: serviceLocator(),
        createCourseSection: serviceLocator(),
      )..add(OnFetchCourse(courseId)),
      child: BlocConsumer<ManageCourseDetailsBloc, ManageCourseDetailsState>(
        listener: (context, state) {
          final updateCourseResult = state.updateCourseResult;
          final updateCourseSectionResult = state.submitCourseSectionResult;
          if (updateCourseResult is ApiResultFailure<Course>) {
            toastification.show(
                type: ToastificationType.error,
                title: Text(
                    updateCourseResult.errorMessage ?? 'Something went wrong'));
          }
          if (updateCourseSectionResult is ApiResultFailure<CourseSection>) {
            toastification.show(
                type: ToastificationType.error,
                title: Text(updateCourseSectionResult.errorMessage ??
                    'Something went wrong'));
          }
        },
        builder: (context, state) {
          final courseResult = state.courseResult;
          return Scaffold(
            extendBodyBehindAppBar: true,
            bottomSheet: ManageCourseDetailsBottomNavSheet(
              courseId: courseId,
            ),
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
              child: _buildContent(courseResult),
            ),
          );
        },
      ),
    );
  }
}

class ManageCourseDetailsSuccessContent extends StatelessWidget {
  final String courseId;
  const ManageCourseDetailsSuccessContent({super.key, required this.courseId});

  void _handlePublishCourse(
      BuildContext context, Course course, CoursePublishStatus newStatus) {
    context.read<ManageCourseDetailsBloc>().add(OnUpdateCourseStatus(
          status: newStatus,
          onSuccess: () {},
          courseId: course.id,
        ));
  }

  Widget _buildPublishStatusButton(BuildContext context, Course course) {
    final state = context.read<ManageCourseDetailsBloc>().state;
    switch (course.statusEnum) {
      case CoursePublishStatus.UNDER_REVIEW:
      case CoursePublishStatus.DRAFT:
        return SizedBox(
          width: double.maxFinite,
          child: CustomButton(
            isLoading: state.updateCourseResult is ApiResultLoading,
            enabled: state.updateCourseResult is! ApiResultLoading,
            onPressed: () {
              _handlePublishCourse(
                  context, course, CoursePublishStatus.PUBLISHED);
            },
            child: const Text("Publish"),
          ),
        );
      case CoursePublishStatus.PUBLISHED:
        return SizedBox(
          width: double.maxFinite,
          child: CustomButton(
            isLoading: state.updateCourseResult is ApiResultLoading,
            enabled: state.updateCourseResult is! ApiResultLoading,
            onPressed: () {
              _handlePublishCourse(
                  context, course, CoursePublishStatus.UNDER_REVIEW);
            },
            child: const Text("Turn to review"),
          ),
        );
    }
  }

  void _showEditOverviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ManageCourseDetailsBloc>(context),
          child: EditCourseDetailsBottomSheet(
            courseId: courseId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      listener: (context, state) {
        var errorMessage = "Something went wrong";
        final updateCourseResult = state.updateCourseResult;
        final submitCoursePartResult = state.submitCoursePartResult;
        final submitCourseSectionResult = state.submitCourseSectionResult;
        if (updateCourseResult is ApiResultFailure<Course> &&
            updateCourseResult.errorMessage != null) {
          errorMessage = updateCourseResult.errorMessage!;
          toastification.show(
              type: ToastificationType.error, title: Text(errorMessage));
        }
        if (submitCoursePartResult is ApiResultFailure<CoursePart> &&
            submitCoursePartResult.errorMessage != null) {
          errorMessage = submitCoursePartResult.errorMessage!;
          toastification.show(
              type: ToastificationType.error, title: Text(errorMessage));
        }
        if (submitCourseSectionResult is ApiResultFailure<CourseSection> &&
            submitCourseSectionResult.errorMessage != null) {
          errorMessage = submitCourseSectionResult.errorMessage!;
          toastification.show(
              type: ToastificationType.error, title: Text(errorMessage));
        }
      },
      builder: (context, state) {
        final courseResult = state.courseResult;
        if (courseResult is ApiResultSuccess<Course>) {
          final course = courseResult.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    course.statusEnum.buildStatusChip(),
                    Text(
                      courseResult.data.title,
                      style: CustomFonts.titleExtraLarge,
                    ),
                    6.kH,
                    CustomTag.grey(
                      child:
                          Text(courseResult.data.category.title.capitalize()),
                    ),
                    12.kH,
                    ReviewStar(
                      review: courseResult.data.reviewRating,
                    ),
                    12.kH,
                    Text(
                      course.displayPrice,
                      style: CustomFonts.titleMedium,
                    ),
                    12.kH,
                    SizedBox(
                      width: double.maxFinite,
                      child: CustomButton(
                        style: CustomButtonStyle.secondaryBlue,
                        onPressed: () {
                          _showEditOverviewBottomSheet(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const HeroIcon(
                              HeroIcons.pencil,
                              color: CustomColors.primaryBlue,
                              size: 20,
                            ),
                            6.kW,
                            const Text("Edit")
                          ],
                        ),
                      ),
                    ),
                    8.kH,
                    _buildPublishStatusButton(context, course),
                    12.kH,
                    BeforeStartingCourseContent(
                      course: course,
                    ),
                  ],
                ),
              ),
              8.kH,
              ManageCourseDetailsTabView(
                courseId: courseId,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ManageCourseDetailsLoadingContent extends StatelessWidget {
  const ManageCourseDetailsLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;
        if (courseResult is ApiResultLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.75,
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
                    6.kH,
                    Skeleton(
                      width: 60,
                      height: 30,
                    ),
                    12.kH,
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
