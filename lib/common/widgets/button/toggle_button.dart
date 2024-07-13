import 'package:education_app/common/theme/color.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const CustomToggleButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.containerLightBlue : Colors.white,
          border: Border.all(
            color:
                isSelected ? CustomColors.primaryBlue : const Color(0xFFE9E9E9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    blurRadius: 7.5,
                    offset: const Offset(0, 2),
                    color: CustomColors.primaryBlue.withOpacity(0.6),
                  )
                ]
              : null,
        ),
        child: Opacity(
          opacity: isSelected ? 1 : 0.6,
          child: child,
        ),
      ),
    );
  }
}
