import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/video_player/video_player_wrapper_screen.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

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
    required this.headerValue,
    required this.subtitleValue,
    this.isExpanded = false,
  });

  String headerValue;
  String subtitleValue;
  bool isExpanded;
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
          headerValue: 'Section ${index + 1} - ${section.title}',
          subtitleValue: '${section.parts.length} parts',
          isExpanded: false,
        );
      });
    } else {
      expandSectionItems = [];
    }
  }

  void _handlePartContentPressed(CoursePart partContent) {
    if (partContent.isVideoIncluded) {
      context.push(
        VideoPlayerWrapperScreen.route,
        extra: partContent.resourceUrl,
      );
    }
  }

  Widget _buildPartsContent(int sectionIndex) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      shrinkWrap: true,
      itemCount: widget.courseSections[sectionIndex].parts.length,
      itemBuilder: (context, index) {
        final CoursePart partContent =
            widget.courseSections[sectionIndex].parts[index];
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partContent.title,
                      style: CustomFonts.bodyMedium,
                    ),
                    Text(
                      partContent.isVideoIncluded ? "Video" : "Article",
                      style: CustomFonts.labelExtraSmall
                          .copyWith(color: CustomColors.textGrey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: HeroIcon(
                  partContent.isVideoIncluded
                      ? HeroIcons.playCircle
                      : HeroIcons.chevronRight,
                ),
              ),
              6.kW,
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                  title: Text(item.headerValue),
                  subtitle: Text(
                    item.subtitleValue,
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
    );
  }
}
