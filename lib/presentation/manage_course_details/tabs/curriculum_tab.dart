import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/presentation/manage_course_details/tabs/about_tab.dart';
import 'package:education_app/presentation/manage_course_details/widgets/edit_section_bottom_sheet.dart';
import 'package:education_app/presentation/manage_course_details/widgets/new_course_part_bottom_sheet.dart';
import 'package:education_app/presentation/manage_course_details/widgets/new_course_section_bottom_sheet.dart';
import 'package:education_app/presentation/video_player/video_player_wrapper_screen.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';

class ManageCourseCurriculumTabContent extends StatelessWidget {
  const ManageCourseCurriculumTabContent({super.key});

  Widget _buildCurriculumContent(ApiResult<Course> courseResult) {
    if (courseResult is ApiResultSuccess<Course>) {
      return CurriculumExpansionPanel(
        courseSections: courseResult.data.sections,
      );
    }
    return Text("loading");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Column(
            children: [
              _buildCurriculumContent(courseResult),
            ],
          ),
        );
      },
    );
  }
}

class CurriculumExpandItem {
  CurriculumExpandItem({
    required this.section,
    this.isExpanded = false,
  });

  CourseSection section;
  bool isExpanded;

  String get headerText {
    return "Section ${section.order} - ${section.title}";
  }

  String get subtitleText {
    return '${section.parts.length} parts';
  }
}

class CurriculumExpansionPanel extends StatefulWidget {
  final List<CourseSection> courseSections;
  const CurriculumExpansionPanel({
    super.key,
    required this.courseSections,
  });

  @override
  State<CurriculumExpansionPanel> createState() =>
      _CurriculumExpansionPanelState();
}

class _CurriculumExpansionPanelState extends State<CurriculumExpansionPanel> {
  late List<CurriculumExpandItem> expandSectionItems;

  @override
  void initState() {
    super.initState();
    if (widget.courseSections.isNotEmpty) {
      expandSectionItems = List.generate(widget.courseSections.length, (index) {
        final section = widget.courseSections[index];
        return CurriculumExpandItem(
          isExpanded: false,
          section: section,
        );
      });
    } else {
      expandSectionItems = [];
    }
  }

  void _handlePartContentPressed(CoursePart partContent) {
    if (partContent.resource.mimeTypeEnum == CourseResourceMimeType.VIDEO) {
      context.push(
        VideoPlayerWrapperScreen.route,
        extra: partContent.resource.url,
      );
    }
  }

  void _showNewCoursePartBottomSheet(CourseSection section) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      builder: (modalContext) {
        return BlocProvider.value(
            value: BlocProvider.of<ManageCourseDetailsBloc>(context),
            child: NewCoursePartBottomSheet(
              selectedSection: section,
            ));
      },
    );
  }

  void _showEditCoursePartBottonSheet(CourseSection section, int partIndex) {
    final coursePartToEdit = section.parts[partIndex];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ManageCourseDetailsBloc>(context),
          child: NewCoursePartBottomSheet(
            selectedSection: section,
            part: coursePartToEdit,
          ),
        );
      },
    );
  }

  Widget _buildPartsContent(int sectionIndex) {
    final courseSection = widget.courseSections[sectionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          itemCount: courseSection.parts.length,
          itemBuilder: (context, index) {
            final CoursePart partContent = courseSection.parts[index];
            return InkWell(
              onTap: () {
                _handlePartContentPressed(partContent);
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: 30,
                    child: Text(
                      index.toString(),
                      style: CustomFonts.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  4.kW,
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partContent.title,
                              style: CustomFonts.bodyMedium,
                            ),
                            Text(
                              partContent.resource.mimeTypeEnum.displayLabel,
                              style: CustomFonts.labelExtraSmall
                                  .copyWith(color: CustomColors.textGrey),
                            ),
                          ],
                        ),
                        6.kW,
                        SmallEditButton(
                          onPressed: () {
                            _showEditCoursePartBottonSheet(
                                courseSection, index);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: partContent.resource.mimeTypeEnum.buildIcon(),
                  ),
                  6.kW,
                ],
              ),
            );
          },
        ),
        12.kH,
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding,
            vertical: 10,
          ),
          child: CustomButton(
            style: CustomButtonStyle.secondaryBlue,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: CustomColors.slate300),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            onPressed: () {
              _showNewCoursePartBottomSheet(courseSection);
            },
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeroIcon(
                  HeroIcons.plus,
                  size: 14.0,
                  color: CustomColors.primaryBlue,
                ),
                4.kW,
                Text(
                  "Add NEW Part",
                  style: CustomFonts.labelExtraSmall
                      .copyWith(color: CustomColors.primaryBlue),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEditSectionBottomSheet(CourseSection section) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ManageCourseDetailsBloc>(context),
          child: EditSectionBottomSheet(section: section),
        );
      },
    );
  }

  void _showNewCourseSectionBottomSheet() {
    final courseId = GoRouterState.of(context).pathParameters['courseId'] ?? "";
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ManageCourseDetailsBloc>(context),
          child: NewCourseSectionBottomSheet(
            courseId: courseId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.screenHorizontalPadding,
                vertical: 10,
              ),
              child: CustomButton(
                style: CustomButtonStyle.secondaryBlue,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: CustomColors.slate300),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onPressed: _showNewCourseSectionBottomSheet,
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HeroIcon(
                      HeroIcons.plus,
                      size: 14.0,
                      color: CustomColors.primaryBlue,
                    ),
                    4.kW,
                    Text(
                      "Add NEW Section",
                      style: CustomFonts.labelExtraSmall
                          .copyWith(color: CustomColors.primaryBlue),
                    )
                  ],
                ),
              ),
            ),
            BlocListener<ManageCourseDetailsBloc, ManageCourseDetailsState>(
              listenWhen: (previous, current) {
                // Trigger section update
                final prevSubmitCourseSectionResult =
                    previous.submitCourseSectionResult;
                final curSubmitCourseSectionResult =
                    current.submitCourseSectionResult;
                if (prevSubmitCourseSectionResult
                        is! ApiResultSuccess<CourseSection> &&
                    curSubmitCourseSectionResult
                        is ApiResultSuccess<CourseSection>) {
                  return true;
                }

                // Trigger part update
                final prevSubmitCoursePartResult =
                    previous.submitCoursePartResult;
                final curSubmitCoursePartResult =
                    current.submitCoursePartResult;
                if (prevSubmitCoursePartResult
                        is! ApiResultSuccess<CoursePart> &&
                    curSubmitCoursePartResult is ApiResultSuccess<CoursePart>) {
                  return true;
                }
                return false;
              },
              listener: (context, state) {
                final courseResult = state.courseResult;
                if (courseResult is ApiResultSuccess<Course>) {
                  setState(() {
                    expandSectionItems = List.generate(
                        courseResult.data.sections.length, (index) {
                      final section = courseResult.data.sections[index];
                      return CurriculumExpandItem(
                        isExpanded: false,
                        section: section,
                      );
                    });
                  });
                }
              },
              child: ExpansionPanelList(
                dividerColor: CustomColors.containerBorderGrey,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    expandSectionItems[index].isExpanded = !isExpanded;
                  });
                },
                children: expandSectionItems.mapWithIndex<ExpansionPanel>(
                    (CurriculumExpandItem item, int index) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: Colors.white,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        titleTextStyle: CustomFonts.labelMedium,
                        title: Row(
                          children: [
                            Flexible(child: Text(item.headerText)),
                            6.kW,
                            SmallEditButton(onPressed: () {
                              _showEditSectionBottomSheet(item.section);
                            }),
                          ],
                        ),
                        subtitle: Text(
                          item.subtitleText,
                          style: CustomFonts.bodySmall.copyWith(
                            color: CustomColors.textGrey,
                          ),
                        ),
                        tileColor: Colors.white,
                      );
                    },
                    body: _buildPartsContent(index),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
