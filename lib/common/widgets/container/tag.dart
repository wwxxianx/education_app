import 'package:education_app/common/theme/color.dart';
import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry padding;
  const CustomTag({
    super.key,
    required this.child,
    this.bgColor,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
  });

  const CustomTag.blue({
    super.key,
    this.bgColor = CustomColors.lightBlue,
    this.foregroundColor = CustomColors.accentBlue,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
  });

  const CustomTag.grey({
    super.key,
    this.bgColor = const Color(0xFFF1F7FF),
    this.foregroundColor = const Color(0xFF475569),
    required this.child,
    this.padding = const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: child,
    );
  }
}
