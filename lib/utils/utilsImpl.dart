import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:ombiapp/services/secure_storage_service.dart';

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

  static String buildLink(String link) {
    return "${GlobalConfiguration().getString('API_ADDRESS_PREFIX')}${link}${GlobalConfiguration().getString('API_ADDRESS_SUFFIX')}";
  }

   static final DateFormat dateFormat = DateFormat('MM-yyyy');
}

