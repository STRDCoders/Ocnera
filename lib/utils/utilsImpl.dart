import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';

import 'grid.dart';
import 'logger.dart';

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

  static num getScreenRatio(BuildContext context){
    return getScreenHeight(context, true)/getScreenWidth(context);
  }

  static String buildLink(String link) {
    return "${GlobalConfiguration().getString(
        'API_ADDRESS_PREFIX')}${link}${GlobalConfiguration().getString(
        'API_ADDRESS_SUFFIX')}";
  }

  static final DateFormat dateFormat = DateFormat('MM-yyyy');

  static ScreenSize getScreenType(BuildContext context) {
    var height = getScreenHeight(context, false);
    for (var i = 1; i < SCREEN_SIZE_RESOLUTION.length; i++) {
      if (height < SCREEN_SIZE_RESOLUTION[i]) {
       logger.d(ScreenSize.values[i-1]);
        return ScreenSize.values[i - 1];
      }
    }
  }
}
