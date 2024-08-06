import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class CourseVoucherList extends StatelessWidget {
  const CourseVoucherList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        final courseVoucherResult = state.courseVoucherResult;
        if (courseVoucherResult is ApiResultLoading) {
          return const Text("Loading..");
        }
        if (courseVoucherResult is ApiResultFailure<List<CourseVoucher>>) {
          return const Text("Error...");
        }
        if (courseVoucherResult is ApiResultSuccess<List<CourseVoucher>>) {
          return RawScrollbar(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.screenHorizontalPadding),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: courseVoucherResult.data.length,
                itemBuilder: (context, index) {
                  final courseVoucher = courseVoucherResult.data[index];
                  return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: CourseVoucherItem(voucher: courseVoucher),);
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CourseVoucherItem extends StatelessWidget {
  final CourseVoucher voucher;
  const CourseVoucherItem({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: CustomColors.containerBorderSlate),
        boxShadow: CustomColors.containerSlateShadow,
      ),
      child: Column(
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
          Text(
            voucher.displayVoucherPrice,
            style: CustomFonts.labelLarge,
          ),
          8.kH,
          Row(
            children: [
              HeroIcon(
                HeroIcons.calendar,
                size: 20,
                color: CustomColors.textGrey,
              ),
              4.kW,
              if (voucher.expiredAt != null)
                Text("until ${voucher.expiredAt!.toISODate()}"),
              if (voucher.expiredAt == null)
                Text(
                  "No expiration",
                  style: CustomFonts.bodySmall.copyWith(
                    color: CustomColors.textGrey,
                  ),
                ),
            ],
          ),
          8.kH,
          Text(
            "Stock: ${voucher.stock != null ? voucher.stock.toString() : "Unlimited"}",
            style: CustomFonts.labelMedium,
          ),
        ],
      ),
    );
  }
}
