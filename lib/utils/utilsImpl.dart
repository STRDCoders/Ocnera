import 'package:flutter/widgets.dart';

class UtilsImpl {
  static num timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch;

  static num getScreenHeight(BuildContext context, bool safeArea) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    if (safeArea) {
      var padding = MediaQuery
          .of(context)
          .padding;
      return height - padding.top - padding.bottom;
    }

    return height;
  }

  static num getScreenWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }
}
