import 'package:education_app/common/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';

class CustomBadge extends StatelessWidget {
  final Widget child;
  final badges.BadgeStyle? badgeStyle;
  final badges.BadgeAnimation? badgeAnimation;
  final badges.BadgePosition? position;
  final String badgeText;
  final bool showBadge;
  final Function()? onTap;
  const CustomBadge({
    super.key,
    required this.badgeText,
    required this.child,
    this.badgeStyle,
    this.badgeAnimation,
    this.position,
    this.showBadge = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: showBadge,
      badgeContent: Text(
        badgeText,
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 10,
            color: CustomColors.primaryBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.square,
        badgeColor: CustomColors.containerLightBlue,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        borderRadius: BorderRadius.circular(2),
        borderSide:
            const BorderSide(color: CustomColors.containerBorderBlue, width: 1),
        elevation: 0,
      ),
      position: position,
      child: child,
    );
  }
}
