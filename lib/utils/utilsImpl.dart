import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';

class UtilsImpl {
  static num timestamp() => DateTime.now().millisecondsSinceEpoch;

  static num getScreenHeight(BuildContext context, bool safeArea) {
    double height = MediaQuery.of(context).size.height;
    if (safeArea) {
      var padding = MediaQuery.of(context).padding;
      return height - padding.top - padding.bottom;
    }
    return height;
  }

  static num getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static num getScreenRatio(BuildContext context) {
    return getScreenHeight(context, true) / getScreenWidth(context);
  }

  static String buildLink(String link) {
    return "${GlobalConfiguration().getValue('API_ADDRESS_PREFIX')}$link${GlobalConfiguration().getValue('API_ADDRESS_SUFFIX')}";
  }

  static final DateFormat dateFormat = DateFormat('MM-yyyy');
}
