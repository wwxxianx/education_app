import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class FAQBottomSheet extends StatelessWidget {
  final String courseId;
  const FAQBottomSheet({
    super.key,
    required this.courseId,
  });

  void _handleAddFAQ(BuildContext context) {
    context.read<ManageCourseDetailsBloc>().add(OnAddFAQ());
  }

  void _handleSubmit(BuildContext context) {
    context
        .read<ManageCourseDetailsBloc>()
        .add(OnUpdateCourseFAQ(courseId: courseId, onSuccess: () {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.9,
          footer: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
              vertical: 10,
            ),
            child: SizedBox(
              width: double.maxFinite,
              child: CustomButton(
                isLoading: state.updateCourseFAQResult is ApiResultLoading,
                enabled: state.updateCourseFAQResult is! ApiResultLoading,
                onPressed: () {
                  _handleSubmit(context);
                },
                child: const Text("Save"),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        "assets/icons/message-question-filled.svg"),
                    6.kW,
                    const Text(
                      "Course FAQ",
                      style: CustomFonts.titleMedium,
                    ),
                  ],
                ),
                20.kH,
                FAQForm(),
                12.kH,
                SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    style: CustomButtonStyle.secondaryBlue,
                    onPressed: () {
                      _handleAddFAQ(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const HeroIcon(
                          HeroIcons.plus,
                          size: 20,
                          color: CustomColors.primaryBlue,
                        ),
                        6.kW,
                        Text(
                          "Add Question",
                          style: CustomFonts.labelSmall
                              .copyWith(color: CustomColors.primaryBlue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FAQForm extends StatelessWidget {
  const FAQForm({
    super.key,
  });

  void _handleQuestionChanged(BuildContext context, int index, String value) {
    context
        .read<ManageCourseDetailsBloc>()
        .add(OnFAQQuestionChanged(index: index, value: value));
  }

  void _handleAnswerChanged(BuildContext context, int index, String value) {
    context
        .read<ManageCourseDetailsBloc>()
        .add(OnFAQAnswerChanged(index: index, value: value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        if (state.courseFAQResult is ApiResultSuccess<List<CourseFAQ>>) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.courseFAQList.length,
            itemBuilder: (context, index) {
              final courseFAQ = state.courseFAQList[index];
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFDCDCDC)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomOutlinedTextfield(
                      label: "Question:",
                      initialValue: courseFAQ.question,
                      onChanged: (value) {
                        _handleQuestionChanged(context, index, value);
                      },
                    ),
                    12.kH,
                    CustomOutlinedTextfield(
                      label: "Answer:",
                      initialValue: courseFAQ.answer,
                      onChanged: (value) {
                        _handleAnswerChanged(context, index, value);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        if (state.courseFAQResult is ApiResultLoading) {
          return Text("Loading...");
        }
        return SizedBox.shrink();
      },
    );
  }
}
