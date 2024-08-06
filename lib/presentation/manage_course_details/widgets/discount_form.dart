import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/button/date_picker_button.dart';
import 'package:education_app/common/widgets/input/money_input.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

class DiscountForm extends StatefulWidget {
  final String courseId;
  const DiscountForm({
    super.key,
    required this.courseId,
  });

  @override
  State<DiscountForm> createState() => _DiscountFormState();
}

class _DiscountFormState extends State<DiscountForm> {
  bool isLimitedOffer = false;
  bool isExpirationOffer = false;

  void _handleSubmit() {
    context.read<ManageCourseDetailsBloc>().add(OnCreateCourseVoucher(
          courseId: widget.courseId,
          onSuccess: () {
            toastification.show(
              type: ToastificationType.success,
              title: Text("Voucher created!"),
              icon: SvgPicture.asset("assets/icons/ticket.svg"),
            );
          },
        ));
  }

  void _toggleLimitedOffer(bool value) {
    setState(() {
      isLimitedOffer = value;
    });
  }

  void _toggleExpirationOffer(bool value) {
    setState(() {
      isExpirationOffer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      listener: (context, state) {
        final createVoucherResult = state.createVoucherResult;
        if (createVoucherResult is ApiResultFailure<CourseVoucher>) {
          toastification.show(
            type: ToastificationType.error,
            title: Text(
                createVoucherResult.errorMessage ?? "Something went wrong"),
          );
        }
      },
      child: RawScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: CustomColors.containerBorderSlate),
                    boxShadow: CustomColors.containerSlateShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Discount Details",
                        style: CustomFonts.labelMedium,
                      ),
                      8.kH,
                      Text(
                        'Original Price',
                        style: CustomFonts.bodySmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                      4.kH,
                      Text(
                        'RM199',
                        style: CustomFonts.bodySmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                      8.kH,
                      MoneyTextField(
                        label: "After discount:",
                        onChanged: (value) {
                          context.read<ManageCourseDetailsBloc>().add(
                                OnDiscountChanged(
                                  value: value,
                                ),
                              );
                        },
                      ),
                      8.kH,
                      CustomOutlinedTextfield(
                        label: "Title",
                        onChanged: (value) {
                          context.read<ManageCourseDetailsBloc>().add(
                                OnVoucherTitleChanged(
                                  value: value,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                20.kH,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: CustomColors.containerBorderSlate),
                    boxShadow: CustomColors.containerSlateShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Switch(
                            // This bool value toggles the switch.
                            value: isLimitedOffer,
                            activeColor: Colors.white,
                            activeTrackColor: CustomColors.slate900,
                            onChanged: _toggleLimitedOffer,
                          ),
                          6.kW,
                          const Text(
                            'Limited Offer',
                            style: CustomFonts.labelSmall,
                          ),
                        ],
                      ),
                      4.kH,
                      Text(
                        'This discount will be only available to the number of sales you specified.',
                        style: CustomFonts.bodyExtraSmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                      8.kH,
                      if (isLimitedOffer)
                        CustomOutlinedTextfield(
                          label: "Numbers of offer:",
                          onChanged: (value) {
                            context.read<ManageCourseDetailsBloc>().add(
                                  OnVoucherStockChanged(
                                    value: value,
                                  ),
                                );
                          },
                        ),
                    ],
                  ),
                ),
                20.kH,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: CustomColors.containerBorderSlate),
                    boxShadow: CustomColors.containerSlateShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Switch(
                            // This bool value toggles the switch.
                            value: isExpirationOffer,
                            activeColor: Colors.white,
                            activeTrackColor: CustomColors.slate900,
                            onChanged: _toggleExpirationOffer,
                          ),
                          6.kW,
                          const Text(
                            'Expiration',
                            style: CustomFonts.labelSmall,
                          ),
                        ],
                      ),
                      4.kH,
                      Text(
                        'The discount is only available before the time you specified.',
                        style: CustomFonts.bodyExtraSmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                      8.kH,
                      if (isExpirationOffer)
                        DatePickerButton(
                          onSelected: (selectedDateTime) {
                            context.read<ManageCourseDetailsBloc>().add(
                                  OnVoucherExpirationDateChanged(
                                    value: selectedDateTime,
                                  ),
                                );
                          },
                        ),
                    ],
                  ),
                ),
                12.kH,
                BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: CustomButton(
                        isLoading:
                            state.createVoucherResult is ApiResultLoading,
                        enabled: state.createVoucherResult is! ApiResultLoading,
                        onPressed: _handleSubmit,
                        child: Text("Create"),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
