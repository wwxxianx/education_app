import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters from the new value
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Add the auto-applied "-" and white spaces
    String formattedText = '';
    for (int i = 0; i < cleanedText.length; i++) {
      if (i == 2 || i == 6) {
        formattedText += '-';
      }
      formattedText += cleanedText[i];
    }

    if (formattedText.length >= 12) {
      formattedText = formattedText.substring(0, 12);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}