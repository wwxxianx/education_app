import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void showSnackBar(String content) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
        ),
      );
  }
}
