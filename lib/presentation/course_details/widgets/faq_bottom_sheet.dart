import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course_faq.dart';
import 'package:education_app/state_management/course_details/course_details_bloc.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseFAQBottomSheet extends StatelessWidget {
  const CourseFAQBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        final courseFAQResult = state.courseFAQResult;
        return CustomDraggableSheet(
          initialChildSize: 0.4,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
            child: Column(
              children: [
                if (courseFAQResult is ApiResultSuccess<List<CourseFAQ>>)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseFAQResult.data.length,
                    itemBuilder: (context, index) {
                      final courseFAQ = courseFAQResult.data[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: CustomColors.containerBorderSlate),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Q: ${courseFAQ.question}"),
                            6.kH,
                            Text("A: ${courseFAQ.answer}"),
                          ],
                        ),
                      );
                    },
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
