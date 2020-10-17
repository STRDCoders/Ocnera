import 'package:flutter/material.dart';

class AppTheme {
  static const APP_BACKGROUND = Color.fromARGB(245, 31, 31, 31);
  static const DATA_BACKGROUND = Colors.white12;
  static const BUTTON_COLOR = Colors.orange;
  static theme(BuildContext context) => ThemeData(
//TODO - fix color of copy/paste buttons.
        popupMenuTheme: PopupMenuThemeData(
            color: AppTheme.APP_BACKGROUND,
            textStyle: TextStyle(color: Colors.white)),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        iconTheme: IconThemeData(color: Colors.orangeAccent),
        buttonTheme: ButtonThemeData(
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
            buttonColor: BUTTON_COLOR,
            disabledColor: Colors.grey.withOpacity(0.7),
            textTheme: ButtonTextTheme.accent),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.grey),
        ),
        appBarTheme: AppBarTheme(color: APP_BACKGROUND),
        scaffoldBackgroundColor: APP_BACKGROUND,
      );
}
