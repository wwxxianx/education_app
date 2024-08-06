import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/container/selectable_container.dart';
import 'package:education_app/domain/model/voucher/user_voucher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserVoucherItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final UserVoucher userVoucher;
  const UserVoucherItem({super.key, required this.userVoucher, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SelectableContainer(
      isSelected: isSelected,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/ticket.svg"),
              6.kW,
              Text(
                userVoucher.voucher?.title ?? "",
                style: CustomFonts.labelSmall,
              ),
            ],
          ),
          4.kH,
          Text(
            userVoucher.voucher?.displayVoucherPrice ?? "",
            style: CustomFonts.labelLarge,
          ),
        ],
      ),
    );
  }
}
