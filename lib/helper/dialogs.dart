import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red.withOpacity(.8),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}
