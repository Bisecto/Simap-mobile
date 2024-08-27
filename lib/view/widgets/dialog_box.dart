import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
class MSG {
  static snackBar(BuildContext context, String message, {String title = 'Message'} ) {
    try {
      AnimatedSnackBar.rectangle(
        title,
        message,
        type: AnimatedSnackBarType.success,
        duration: const Duration(seconds: 5),
        brightness: Brightness.light,
      ).show(
        context,
      );
    } catch (e) {
    }
  }

  static errorSnackBar(BuildContext context, String message, {String title = 'Error massage'}) {
    try {
      AnimatedSnackBar.rectangle(
        title,
        message,
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 10),
        brightness: Brightness.light,
      ).show(
        context,
      );
    } catch (e) {
    }
  }
  static warningSnackBar(BuildContext context, String message, {String title = 'Warning message'}) {
    try {
      AnimatedSnackBar.rectangle(
        title,
        message,
        type: AnimatedSnackBarType.warning,
        duration: const Duration(seconds: 5),
        brightness: Brightness.light,
      ).show(
        context,
      );
    } catch (e) {
      ///(e);
    }
  }
  static infoSnackBar(BuildContext context, String message, {String title = 'Error massage'}) {

    try {
      AnimatedSnackBar.rectangle(
        title,
        message,
        type: AnimatedSnackBarType.info,
        duration: const Duration(seconds: 7),
        brightness: Brightness.light,
      ).show(
        context,
      );
    } catch (e) {
      ///(e);
    }
  }

}


