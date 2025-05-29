import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
