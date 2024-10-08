import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'package:task_management/provider/app_theme_provider.dart';

class DialogUtils {
  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showLoadingDialog({
    required BuildContext context,
    required String message,
  }) {
    final themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    final isAppDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDarkMode = themeProvider.themeMode == ThemeMode.system
        ? isSystemDarkMode
        : isAppDarkMode;

    if (Platform.isIOS || Platform.isMacOS) {
      // iOS Style
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoTheme(
            data: CupertinoThemeData(
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
              primaryColor: isDarkMode ? Colors.white : Colors.blue,
              scaffoldBackgroundColor: isDarkMode
                  ? Colors.black.withOpacity(0.8)
                  : Colors.white.withOpacity(0.8),
            ),
            child: CupertinoAlertDialog(
              title: const CupertinoActivityIndicator(),
              content: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      // Android Style
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Center(child: CircularProgressIndicator()),
            content: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showAlertDialog({
    required BuildContext context,
    String? title,
    String? message,
    String? posActionTitle,
    String? negActionTitle,
    String? thirdActionTitle,
    Function? posAction,
    Function? negAction,
    Function? thirdAction,
    Color posColor = const Color.fromARGB(255, 95, 155, 235),
    Color negColor = const Color.fromARGB(255, 235, 75, 75),
    Color thirdColor = const Color.fromARGB(255, 95, 155, 235),
  }) {
    final themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    final isAppDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDarkMode = themeProvider.themeMode == ThemeMode.system
        ? isSystemDarkMode
        : isAppDarkMode;

    List<Widget> actions = [];

    // Build Actions
    if (posActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(
            posActionTitle,
            style: TextStyle(color: posColor, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    if (thirdActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            thirdAction?.call();
          },
          child: Text(
            thirdActionTitle,
            style: TextStyle(color: thirdColor, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    if (negActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            negAction?.call();
          },
          child: Text(
            negActionTitle,
            style: TextStyle(color: negColor, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    // Add dividers for iOS style
    List<Widget> actionsWithSeparators = [];

    for (int i = 0; i < actions.length; i++) {
      actionsWithSeparators.add(actions[i]);
      if (i < actions.length - 1) {
        actionsWithSeparators.add(
          Divider(
            color: isDarkMode
                ? const Color.fromARGB(255, 46, 46, 46)
                : Colors.grey.shade400,
            thickness: 0.6,
          ),
        );
      }
    }

    if (Platform.isIOS || Platform.isMacOS) {
      // iOS Style
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoTheme(
            data: CupertinoThemeData(
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
              primaryColor: isDarkMode ? Colors.white : Colors.blue,
              scaffoldBackgroundColor: isDarkMode
                  ? Colors.black.withOpacity(0.8)
                  : Colors.white.withOpacity(0.8),
            ),
            child: CupertinoAlertDialog(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Text(
                    title ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              content: Container(
                padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                child: Text(
                  message ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
              actions: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: actionsWithSeparators,
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Android Style
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            title: Text(
              title ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            content: Text(
              message ?? '',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            actions: actions,
          );
        },
      );
    }
  }
}
