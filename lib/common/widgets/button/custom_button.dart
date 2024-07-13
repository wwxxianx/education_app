import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:flutter/material.dart';

enum CustomButtonStyle {
  black,
  flatBlue,
  secondaryBlue,
  gradientBlue,
  white,
  grey,
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final double height;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final CustomButtonStyle style;
  final bool isLoading;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool enabled;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.height = 50.0,
    this.elevation = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.padding = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
    this.textStyle = CustomFonts.titleMedium,
    this.style = CustomButtonStyle.flatBlue,
    this.isLoading = false,
    this.boxShadow,
    this.enabled = true,
    this.border,
  }) : super(key: key);

  Color? _getBackgroundColor() {
    switch (style) {
      case CustomButtonStyle.grey:
        return const Color(0xFFF0F0F0);
      case CustomButtonStyle.flatBlue:
        return CustomColors.primaryBlue;
      case CustomButtonStyle.white:
        return Colors.white;
      case CustomButtonStyle.black:
        return Colors.black;
      case CustomButtonStyle.gradientBlue:
        return null;
      default:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor() {
    switch (style) {
      case CustomButtonStyle.grey:
        return const Color(0xFF6C6C6C);
      case CustomButtonStyle.black:
      case CustomButtonStyle.secondaryBlue:
        return CustomColors.primaryBlue;
      case CustomButtonStyle.flatBlue:
        return Colors.white;

      default:
        return Colors.black;
    }
  }

  BoxBorder? _buildBorder() {
    if (border != null) {
      return border;
    }
    if (style == CustomButtonStyle.secondaryBlue) {
      return Border.all(width: 1, color: const Color(0xFFE9E9E9));
    }
    if (style != CustomButtonStyle.flatBlue) {
      return Border.all(width: 1, color: Colors.black);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _bgGradient = style == CustomButtonStyle.gradientBlue
        ? CustomColors.primaryGreenGradient
        : null;

    return Ink(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          gradient: _bgGradient,
          border: _buildBorder(),
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: FilledButton(
          onPressed: enabled ? onPressed : null,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(_getForegroundColor()),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            padding: MaterialStateProperty.all(
              padding,
            ),
            textStyle: MaterialStateProperty.all(textStyle),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: CustomColors.accentGreen,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
