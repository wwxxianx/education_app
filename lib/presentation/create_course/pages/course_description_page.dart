import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/dropdown_menu/language_dropdown_menu.dart';
import 'package:education_app/common/widgets/dropdown_menu/level_dropdown_menu.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDescriptionPage extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  const CourseDescriptionPage({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  State<CourseDescriptionPage> createState() => _CourseDescriptionPageState();
}

class _CourseDescriptionPageState extends State<CourseDescriptionPage> {
  late TextEditingController titleTextController;

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleTextController.dispose();
  }

  void _handleDescriptionChanged(String value) {
    context.read<CreateCourseBloc>().add(OnDescriptionChanged(value: value));
  }

  void _handleTitleChanged(String value) {
    context.read<CreateCourseBloc>().add(OnTitleChanged(value: value));
  }

  void _handleSelectLevel(String id) {
    context.read<CreateCourseBloc>().add(OnSelectLevel(levelId: id));
  }

  void _handleSelectLanguage(String id) {
    context.read<CreateCourseBloc>().add(OnSelectLanguage(languageId: id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseBloc, CreateCourseState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return WillPopScope(
              onWillPop: () async {
                widget.onPreviousPage();
                print('pop');
                return false;
              },
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.screenHorizontalPadding,
                        right: Dimensions.screenHorizontalPadding,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          CustomOutlinedTextfield(
                            controller: titleTextController,
                            label: "Course title",
                            onChanged: _handleTitleChanged,
                          ),
                          20.kH,
                          CustomOutlinedTextfield(
                            label: "Course description",
                            maxLines: 10,
                            onChanged: _handleDescriptionChanged,
                          ),
                          20.kH,
                          LanguagesDropdownMenu(
                            onSelected: _handleSelectLanguage,
                          ),
                          20.kH,
                          CourseLevelDropdownMenu(
                            onSelected: _handleSelectLevel,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onPressed: widget.onNextPage,
                                  child: const Text("Continue"),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
