import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/voucher/claim_voucher_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/course_details/course_details_bloc.dart';
import 'package:education_app/state_management/course_details/course_details_event.dart';
import 'package:education_app/state_management/course_details/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:toastification/toastification.dart';

class VoucherSection extends StatelessWidget {
  final String courseId;
  const VoucherSection({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        final courseVoucherResult = state.courseVoucherResult;
        if (courseVoucherResult is ApiResultSuccess<List<CourseVoucher>>) {
          if (courseVoucherResult.data.isEmpty) {
            return const SizedBox.shrink();
          }
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                elevation: 0,
                isDismissible: true,
                isScrollControlled: true,
                context: context,
                builder: (modalContext) {
                  return BlocProvider.value(
                    value: BlocProvider.of<CourseDetailsBloc>(context),
                    child: ClaimCourseVoucherBottomSheet(
                      vouchers: courseVoucherResult.data,
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding, vertical: 10),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal:
                      BorderSide(color: CustomColors.containerBorderSlate),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/ticket.svg"),
                          4.kW,
                          Text(
                            "Vouchers",
                            style: CustomFonts.labelSmall,
                          ),
                        ],
                      ),
                      2.kH,
                      Text(
                        "There's available vouchers for this course",
                        style: CustomFonts.bodySmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  HeroIcon(
                    HeroIcons.chevronRight,
                    color: CustomColors.slate700,
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class ClaimCourseVoucherBottomSheet extends StatefulWidget {
  final List<CourseVoucher> vouchers;
  const ClaimCourseVoucherBottomSheet({
    super.key,
    required this.vouchers,
  });

  @override
  State<ClaimCourseVoucherBottomSheet> createState() =>
      _ClaimCourseVoucherBottomSheetState();
}

class _ClaimCourseVoucherBottomSheetState
    extends State<ClaimCourseVoucherBottomSheet> {
  @override
  void initState() {
    super.initState();
    final appUserCubit = context.read<AppUserCubit>();
    final vouchersResult = appUserCubit.state.vouchersResult;
    if (vouchersResult is! ApiResultSuccess<List<UserVoucher>>) {
      appUserCubit.fetchUserVouchers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        return CustomDraggableSheet(
          initialChildSize: 0.6,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.screenHorizontalPadding,
              vertical: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.vouchers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: ClaimVoucherItem(
                  voucher: widget.vouchers[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ClaimVoucherItem extends StatelessWidget {
  final CourseVoucher voucher;
  const ClaimVoucherItem({
    super.key,
    required this.voucher,
  });

  bool _isVoucherClaimed(List<UserVoucher> userVouchers) {
    return userVouchers.any((element) => element.voucherId == voucher.id);
  }

  void _handleClaimVoucher(BuildContext context) {
    final payload = ClaimVoucherPayload(voucherId: voucher.id);
    context.read<CourseDetailsBloc>().add(
          OnClaimVoucher(
            payload: payload,
            onSuccess: (voucher) {
              context.read<AppUserCubit>().addNewVoucher(voucher);
              toastification.show(
                autoCloseDuration: const Duration(seconds: 5),
                boxShadow: lowModeShadow,
                showProgressBar: true,
                title: Text("Claimed voucher successful!"),
              );
            },
          ),
        );
  }

  Widget _buildVoucherActionButton(BuildContext context) {
    final claimVoucherResult =
        context.watch<CourseDetailsBloc>().state.claimVoucherResult;
    final appUserCubit = context.watch<AppUserCubit>();
    final userVoucherResult = appUserCubit.state.vouchersResult;

    if (userVoucherResult is ApiResultSuccess<List<UserVoucher>>) {
      if (_isVoucherClaimed(userVoucherResult.data)) {
        return Text(
          "Claimed",
          style: CustomFonts.labelSmall.copyWith(
            color: CustomColors.primaryBlue,
          ),
        );
      }
      return Align(
        alignment: Alignment.bottomRight,
        child: CustomButton(
          isLoading: userVoucherResult is ApiResultLoading ||
              claimVoucherResult is ApiResultLoading,
          enabled: userVoucherResult is! ApiResultLoading ||
              claimVoucherResult is! ApiResultLoading,
          onPressed: () {
            _handleClaimVoucher(context);
          },
          height: 36,
          borderRadius: BorderRadius.circular(4),
          child: Text(
            "Claim",
            style: CustomFonts.labelSmall.copyWith(color: Colors.white),
          ),
        ),
      );
    }
    return const Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: CustomColors.containerBorderSlate),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/ticket.svg"),
                      6.kW,
                      Text(
                        voucher.title,
                        style: CustomFonts.labelSmall,
                      ),
                    ],
                  ),
                  4.kH,
                  Row(
                    children: [
                      if (courseResult is ApiResultSuccess<Course>)
                        Text(
                          courseResult.data.displayPrice,
                          style: CustomFonts.labelSmall.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: CustomColors.textGrey),
                        ),
                      6.kW,
                      Text(
                        voucher.displayVoucherPrice,
                        style: CustomFonts.labelLarge,
                      ),
                    ],
                  ),
                  if (voucher.expiredAt != null &&
                      voucher.expiredAt?.isNotEmpty == true)
                    6.kH,
                  if (voucher.expiredAt != null &&
                      voucher.expiredAt?.isNotEmpty == true)
                    Row(
                      children: [
                        HeroIcon(
                          HeroIcons.calendar,
                          size: 18,
                          color: CustomColors.slate700,
                        ),
                        4.kW,
                        Text(
                          "until ${voucher.expiredAt!.toISODate()}",
                          style: CustomFonts.bodySmall,
                        )
                      ],
                    )
                ],
              ),
              const Spacer(),
              _buildVoucherActionButton(context),
            ],
          ),
        );
      },
    );
  }
}
