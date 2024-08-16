import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/purchase/widgets/available_voucher_list.dart';
import 'package:education_app/presentation/purchase/widgets/master_card_payment_method.dart';
import 'package:education_app/presentation/redirects/purchase_course_success_redirect_screen.dart';
import 'package:education_app/state_management/purchase/purchase_bloc.dart';
import 'package:education_app/state_management/purchase/purchase_event.dart';
import 'package:education_app/state_management/purchase/purchase_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:toastification/toastification.dart';

class PurchaseScreen extends StatelessWidget {
  final String courseId;
  const PurchaseScreen({
    super.key,
    required this.courseId,
  });

  void _handlePurchase(BuildContext context) {
    context.read<PurchaseBloc>().add(
          OnPurchaseCourse(
            courseId: courseId,
            onSuccess: () {
              context.go(PurchaseCourseSuccessRedirectScreen.route);
              toastification.show(
                type: ToastificationType.success,
                title: Text("Purchased!!"),
              );
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PurchaseBloc(
        paymentService: serviceLocator(),
        fetchCourse: serviceLocator(),
      )..add(OnFetchCourse(courseId: courseId)),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                "Purchase",
                style: CustomFonts.titleMedium,
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<PurchaseBloc, PurchaseState>(
              builder: (context, state) {
                final courseResult = state.courseResult;
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.screenHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment method",
                              style: CustomFonts.labelMedium,
                            ),
                            4.kH,
                            Row(
                              children: [
                                const Icon(
                                  Symbols.lock_rounded,
                                  size: 16,
                                  color: CustomColors.textGrey,
                                ),
                                2.kW,
                                Text(
                                  "Secured payment powered by Stripe",
                                  style: CustomFonts.labelSmall.copyWith(
                                    color: CustomColors.textGrey,
                                  ),
                                ),
                              ],
                            ),
                            4.kH,
                            const MasterCardPaymentMethodItem(),
                            20.kH,
                            AvailableVoucherList(courseId: courseId),
                          ],
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: CustomColors.containerBorderSlate),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.screenHorizontalPadding,
                                vertical: 10,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (courseResult is ApiResultLoading)
                                    const Skeleton(
                                      height: Dimensions.loadingBodyHeight,
                                      radius: 8,
                                    ),
                                  if (courseResult is ApiResultSuccess<Course>)
                                    Text(
                                      "Total: ${courseResult.data.displayPrice}",
                                      style: CustomFonts.titleMedium.copyWith(
                                        decoration:
                                            state.selectedVoucher != null
                                                ? TextDecoration.lineThrough
                                                : null,
                                      ),
                                    ),
                                  if (state.selectedVoucher != null)
                                    Text(
                                      "Voucher Applied: ${state.selectedVoucher?.voucher?.displayVoucherPrice ?? ""}",
                                      style: CustomFonts.titleMedium,
                                    ),
                                  12.kH,
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: CustomButton(
                                      onPressed: () {
                                        _handlePurchase(context);
                                      },
                                      child: Text("Confirm Purchase"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
