import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/utils/show_snackbar.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/input/money_input.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/state_management/create_course/create_course_bloc.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class CoursePricePage extends StatefulWidget {
  final VoidCallback onPreviousPage;

  const CoursePricePage({
    super.key,
    required this.onPreviousPage,
  });

  @override
  State<CoursePricePage> createState() => _CoursePricePageState();
}

class _CoursePricePageState extends State<CoursePricePage> {
  void _handlePriceChanged(String value) {
    context.read<CreateCourseBloc>().add(OnPriceChanged(value: value));
  }

  void _handleSubmit() {
    context.read<CreateCourseBloc>().add(OnCreateCourse(onSuccess: () {
      toastification.show(
        title: Text("Created course!"),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCourseBloc, CreateCourseState>(
      listener: (context, state) {
        final createCourseResult = state.createCourseResult;
        if (createCourseResult is ApiResultFailure<Course>) {
          context.showSnackBar(createCourseResult.errorMessage ?? 'Error');
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return WillPopScope(
              onWillPop: () async {
                widget.onPreviousPage();
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Let’s create the first section for your class! Don’t worry, you can keep adding more sections later on.',
                            style: CustomFonts.labelMedium,
                          ),
                          8.kH,
                          MoneyTextField(
                            label: "Cource price",
                            initialValue: state.priceText,
                            onChanged: _handlePriceChanged,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  isLoading: state.createCourseResult
                                      is ApiResultLoading,
                                  enabled: state.createCourseResult
                                      is! ApiResultLoading,
                                  onPressed: _handleSubmit,
                                  child: state.priceText.isNotNullAndEmpty
                                      ? Text("Create")
                                      : Text("Do it later"),
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
