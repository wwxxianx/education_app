import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/input/decorated_input_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOutlinedTextfield extends StatefulWidget {
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final TextAlign textAlign;
  final Widget? suffix;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String value)? onChanged;
  final VoidCallback? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? initialValue;
  final String? errorText;
  final bool readOnly;

  const CustomOutlinedTextfield({
    super.key,
    this.focusNode,
    this.label,
    this.hintText,
    this.controller,
    this.isObscureText = false,
    this.validator,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.suffix,
    this.contentPadding,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.initialValue,
    this.errorText,
    this.readOnly = false,
  });

  @override
  State<CustomOutlinedTextfield> createState() =>
      _CustomOutlinedTextfieldState();
}

class _CustomOutlinedTextfieldState extends State<CustomOutlinedTextfield> {
  bool _isShowingText = true;

  @override
  void initState() {
    super.initState();
    if (widget.isObscureText) {
      _isShowingText = false;
      return;
    }
    _isShowingText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: CustomFonts.labelSmall),
        if (widget.label != null && widget.label!.isNotEmpty) 4.kH,
        TextFormField(
          readOnly: widget.readOnly,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          onTapOutside: widget.onTapOutside,
          onTap: widget.onTap,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: !_isShowingText,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: CustomColors.primaryBlue,
          style: CustomFonts.labelSmall,
          decoration: InputDecoration(
            errorText: widget.errorText,
            suffix: widget.suffix,
            errorMaxLines: 2,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon ??
                (widget.isObscureText
                    ? IconButton(
                        onPressed: () =>
                            setState(() => _isShowingText = !_isShowingText),
                        icon: Icon(_isShowingText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )
                    : null),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: CustomColors.primaryBlue, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadow: BoxShadow(
                blurRadius: 4.0,
                offset: const Offset(0, 0),
                color: CustomColors.primaryBlue.withOpacity(0.6),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: CustomColors.inputBorder, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: widget.prefixIcon != null ? 4.0 : 12.0,
                  vertical: 4.0,
                ),
          ),
        ),
      ],
    );
  }
}
