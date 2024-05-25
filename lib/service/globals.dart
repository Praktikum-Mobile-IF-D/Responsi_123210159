import 'package:flutter/material.dart';

final Color bgBlue = Color.fromARGB(255, 21, 80, 128);

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Text(message)));
}

void showSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bgBlue,
      behavior: SnackBarBehavior.floating,
      content: Text(message)));
}
