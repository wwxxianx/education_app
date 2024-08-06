import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/presentation/manage_course_details/widgets/certificate_bottom_sheet.dart';
import 'package:education_app/presentation/manage_course_details/widgets/discount_bottom_sheet.dart';
import 'package:education_app/presentation/manage_course_details/widgets/faq_bottom_sheet.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_bloc.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManageCourseDetailsBottomNavSheet extends StatelessWidget {
  final String courseId;
  const ManageCourseDetailsBottomNavSheet({
    super.key,
    required this.courseId,
  });

  // void _openCertificateBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isDismissible: true,
  //     elevation: 0,
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (modalContext) {
  //       return BlocProvider.value(
  //         value: BlocProvider.of<ManageCourseDetailsBloc>(context),
//         child: CertificateBottomSheet(),
  //       );
  //     },
  //   );
  // }

  // void _openBankBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isDismissible: true,
  //     elevation: 0,
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (modalContext) {
  //       return BlocProvider.value(
  //         value: BlocProvider.of<ManageCourseDetailsBloc>(context),
  //         child: FAQBottomSheet(),
  //       );
  //     },
  //   );
  // }

  void _openFAQBottomSheet(BuildContext context) {
    context.read<ManageCourseDetailsBloc>().add(OnFetchCourseFAQ(courseId));
    showModalBottomSheet(
      isDismissible: true,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ManageCourseDetailsBloc>(context),
          child: FAQBottomSheet(
            courseId: courseId,
          ),
        );
      },
    );
  }

  void _openDiscountBottomSheet(BuildContext context) {
    context.read<ManageCourseDetailsBloc>().add(OnFetchCourseVouchers(courseId));
    showModalBottomSheet(
      isDismissible: true,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ManageCourseDetailsBloc>(context),
          child: DiscountBottomSheet(courseId: courseId,),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageCourseDetailsBloc, ManageCourseDetailsState>(
      builder: (context, state) {
        final courseResult = state.courseResult;
        return Container(
          height: 67,
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Color(0xFFDFDFDF),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/document-filled.svg'),
                      6.kH,
                      const Text(
                        "Details",
                        style: CustomFonts.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: InkWell(
              //     onTap: () {
              //       // _openCertificateBottomSheet(context);
              //     },
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset('assets/icons/document-badge.svg'),
              //         6.kH,
              //         const Text(
              //           "Certificate",
              //           style: CustomFonts.titleSmall,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    _openFAQBottomSheet(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/message-question.svg'),
                      6.kH,
                      const Text(
                        "FAQ",
                        style: CustomFonts.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    _openDiscountBottomSheet(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/discount.svg'),
                      6.kH,
                      const Text(
                        "Discount",
                        style: CustomFonts.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
