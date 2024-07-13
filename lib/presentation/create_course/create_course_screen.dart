import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/container/step_indicator.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/presentation/create_course/pages/course_category_page.dart';
import 'package:education_app/presentation/create_course/pages/course_curriculum_page.dart';
import 'package:education_app/presentation/create_course/pages/course_description_page.dart';
import 'package:education_app/presentation/create_course/pages/course_media_page.dart';
import 'package:education_app/presentation/create_course/pages/course_overview_page.dart';
import 'package:education_app/presentation/create_course/pages/course_price_page.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCourseScreen extends StatefulWidget {
  static const route = '/create-course';
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen>
    with SingleTickerProviderStateMixin {
  final totalSteps = 4;
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _handlePageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _handleNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _handlePreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Widget _buildStepTitle() {
    late String title;
    switch (currentPage) {
      case 0:
        title = "Course category";
        break;
      case 1:
        title = "Course description";
        break;
      case 2:
        title = "Course media";
        break;
      case 3:
        title = "Course overview";
        break;
      case 4:
        title = "Curriculum";
        break;
      case 5:
        title = "Price";
        break;
    }

    return Text(
      title,
      style: CustomFonts.titleMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCourseBloc(createCourse: serviceLocator()),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              StepIndicator(
                currentStep: "${currentPage + 1}",
                totalSteps: "6",
              ),
              8.kW,
              _buildStepTitle(),
            ],
          ),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: _handlePageChange,
            children: [
              SelectCourseCategoryPage(
                onNextPage: _handleNextPage,
              ),
              CourseDescriptionPage(
                onNextPage: _handleNextPage,
                onPreviousPage: _handlePreviousPage,
              ),
              CourseMediaPage(
                onNextPage: _handleNextPage,
                onPreviousPage: _handlePreviousPage,
              ),
              CourseOverviewPage(
                onNextPage: _handleNextPage,
                onPreviousPage: _handlePreviousPage,
              ),
              CourseCurriculumPage(
                  onNextPage: _handleNextPage,
                  onPreviousPage: _handlePreviousPage,),
              CoursePricePage(onPreviousPage: _handlePreviousPage),
            ],
          ),
        ),
      ),
    );
  }
}
