import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? label;
  final String? errorText;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final bool readOnly;
  const MoneyTextField({
    super.key,
    this.controller,
    this.label,
    this.onChanged,
    this.initialValue,
    this.errorText,
    this.focusNode,
    this.textInputAction,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedTextfield(
      readOnly: readOnly,
      textInputAction: textInputAction,
      focusNode: focusNode,
      errorText: errorText,
      initialValue: initialValue,
      onChanged: onChanged,
      inputFormatters: [
        // Can not start with 0
        FilteringTextInputFormatter.deny(RegExp(r'^0')),
        // Only accept digit
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      contentPadding: const EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
        bottom: 8,
      ),
      keyboardType: TextInputType.number,
      suffixIcon: const Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ".00",
            style: CustomFonts.labelSmall,
          ),
        ],
      ),
      textAlign: TextAlign.end,
      controller: controller,
      label: label,
      prefixIcon: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "RM",
            style: CustomFonts.titleMedium,
          ),
        ],
      ),
    );
  }
}
