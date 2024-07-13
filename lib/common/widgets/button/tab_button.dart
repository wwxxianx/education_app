import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final Widget? prefixIcon;
  const TabItem({
    super.key,
    required this.title,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) prefixIcon!,
          if (prefixIcon != null) 4.kW,
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}