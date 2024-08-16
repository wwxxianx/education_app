import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/presentation/course_details/tabs/about_tab.dart';
import 'package:education_app/presentation/my_learning_details/widgets/review_bottom_sheet.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_bloc.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class MyLearningDetailsMoreTabContent extends StatelessWidget {
  final String courseId;
  const MyLearningDetailsMoreTabContent({
    super.key,
    required this.courseId,
  });

  void _showReviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      elevation: 0,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<MyLearningDetailsBloc>(context),
          child: ReviewBottomSheet(courseId: courseId,),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyLearningDetailsAboutTab(),
            20.kH,
            GestureDetector(
              onTap: () {
                _showReviewBottomSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustomColors.containerBorderSlate),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    HeroIcon(HeroIcons.chartBar),
                    6.kW,
                    Text(
                      "Review",
                      style: CustomFonts.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyLearningDetailsAboutTab extends StatelessWidget {
  const MyLearningDetailsAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLearningDetailsBloc, MyLearningDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;
        return CourseAboutContent(
          courseResult: courseResult,
        );
      },
    );
  }
}
