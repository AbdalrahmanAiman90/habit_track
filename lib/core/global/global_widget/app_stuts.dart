import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppStuts {
  static void showAwesomeSnackBar(
      BuildContext context, ContentType contentType, String message) {
    // Create the snack bar using AwesomeSnackbarContent
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: getSnackBarTitle(
            contentType), // Dynamic title based on content type
        message: message,
        messageTextStyle: TextStyle(fontSize: 18),
        contentType: contentType,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar() // Hide the previous snackbar if visible
      ..showSnackBar(snackBar); // Show the new snackbar
  }

  static String getSnackBarTitle(ContentType contentType) {
    switch (contentType) {
      case ContentType.success:
        return "Success!";
      case ContentType.failure:
        return "Error!";
      case ContentType.warning:
        return "Warning!";
      case ContentType.help:
        return "Help!";
      default:
        return "Notification";
    }
  }

  static Widget myLoading() {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.withOpacity(0.6), // Overlay background
        child: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColor.lodingColor, // Color for the inkDrop animation
            size: 60, // Size of the inkDrop animation
          ),
        ),
      ),
    );
  }
}
