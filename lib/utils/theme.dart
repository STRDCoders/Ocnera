import 'package:flutter/material.dart';

class AppTheme{

  static const APP_BACKGROUND = Color.fromARGB(245, 31, 31, 31);
  static const DATA_BACKGROUND = Colors.white12;
  static theme(BuildContext context) => ThemeData(

      popupMenuTheme: PopupMenuThemeData(
          color: AppTheme.DATA_BACKGROUND,
              textStyle: TextStyle(color:Colors.white)
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: InputBorder.none),
      iconTheme: IconThemeData(color: Colors.orange),
      buttonTheme: ButtonThemeData(
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: Colors.white),
          buttonColor: Colors.orange,
          disabledColor: Colors.grey.withOpacity(0.7),

          textTheme: ButtonTextTheme.accent),
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.grey)),
      scaffoldBackgroundColor: APP_BACKGROUND);
}