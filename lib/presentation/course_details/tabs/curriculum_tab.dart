import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/show_snackbar.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/domain/model/user/user_course.dart';
import 'package:education_app/presentation/video_player/video_player_wrapper_screen.dart';
import 'package:education_app/state_management/course_details/course_details_bloc.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CurriculumTabContent extends StatelessWidget {
  final String courseId;
  final CoursePart? currentFocusPart;
  const CurriculumTabContent({
    super.key,
    required this.courseId,
    this.currentFocusPart,
  });

  Widget _buildCurriculumContent(BuildContext context) {
    final courseResult = context.watch<CourseDetailsBloc>().state.courseResult;
    final userCourseResult =
        context.watch<CourseDetailsBloc>().state.userCourseResult;

    if (courseResult is ApiResultSuccess<Course>) {
      return CurriculumContent(
        currentFocusPart: currentFocusPart,
        sections: courseResult.data.sections,
        onPartContentPressed: (sectionIndex, part) {
          if (userCourseResult is ApiResultSuccess<UserCourse?> &&
              userCourseResult.data != null) {
            context.push("/my-learning/$courseId");
            return;
          }
          if (sectionIndex == 0) {
            // Allow access
            if (part.resource.mimeTypeEnum == CourseResourceMimeType.VIDEO) {
              context.push(VideoPlayerWrapperScreen.route,
                  extra: part.resource.url);
              return;
            }
            launchUrl(
              Uri.parse(part.resource.url),
            );
            return;
          }
          // Dont allow access
          context.showSnackBar('Purchase course to access the content');
        },
      );
    }
    return Text("loading");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Column(
            children: [
              _buildCurriculumContent(context),
            ],
          ),
        );
      },
    );
  }
}

class CurriculumContent extends StatelessWidget {
  final CoursePart? currentFocusPart;
  final List<CourseSection> sections;
  final void Function(int sectionIndex, CoursePart partContent)
      onPartContentPressed;
  const CurriculumContent({
    super.key,
    required this.sections,
    required this.onPartContentPressed,
    required this.currentFocusPart,
  });

  @override
  Widget build(BuildContext context) {
    return CurriculumExpansionPanel(
      courseSections: sections,
      onPartContentPressed: onPartContentPressed,
      currentFocusPart: currentFocusPart,
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
  final CoursePart? currentFocusPart;
  final List<CourseSection> courseSections;
  final void Function(int sectionIndex, CoursePart partContent)
      onPartContentPressed;
  const CurriculumExpansionPanel({
    super.key,
    required this.courseSections,
    required this.onPartContentPressed,
    required this.currentFocusPart,
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

  void _handlePartContentPressed(int sectionIndex, CoursePart partContent) {
    widget.onPartContentPressed(sectionIndex, partContent);
    // if (partContent.resource.mimeTypeEnum == CourseResourceMimeType.VIDEO) {
    //   context.push(
    //     VideoPlayerWrapperScreen.route,
    //     extra: partContent.resource.url,
    //   );
    // }
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
            _handlePartContentPressed(sectionIndex, partContent);
          },
          child: Container(
            decoration: BoxDecoration(
              color: partContent.id == widget.currentFocusPart?.id
                  ? CustomColors.lightBlue
                  : Colors.white,
              border: partContent.id == widget.currentFocusPart?.id
                  ? const Border.symmetric(
                      horizontal: BorderSide(color: CustomColors.primaryBlue))
                  : null,
            ),
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
                        partContent.resource.mimeTypeEnum.displayLabel,
                        style: CustomFonts.labelExtraSmall
                            .copyWith(color: CustomColors.textGrey),
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
