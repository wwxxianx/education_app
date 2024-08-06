import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:education_app/presentation/purchase/widgets/user_voucher_item.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/purchase/purchase_bloc.dart';
import 'package:education_app/state_management/purchase/purchase_event.dart';
import 'package:education_app/state_management/purchase/purchase_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableVoucherList extends StatefulWidget {
  final String courseId;
  const AvailableVoucherList({
    super.key,
    required this.courseId,
  });

  @override
  State<AvailableVoucherList> createState() => _AvailableVoucherListState();
}

class _AvailableVoucherListState extends State<AvailableVoucherList> {
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
    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        final appUserCubit = context.read<AppUserCubit>();
        final appUserState = appUserCubit.state;
        final userVouchers = appUserState.availableVouchers(widget.courseId);
        if (userVouchers.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your voucher",
                style: CustomFonts.labelMedium,
              ),
              12.kH,
              SizedBox(
                height: 200,
                child: RawScrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userVouchers.length,
                    itemBuilder: (context, index) {
                      final userVoucher = userVouchers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: UserVoucherItem(
                          isSelected: state.selectedVoucher == userVoucher,
                          onTap: () {
                            context
                                .read<PurchaseBloc>()
                                .add(OnSelectVoucher(userVoucher: userVoucher));
                          },
                          userVoucher: userVoucher,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
