import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/services/network/http_override.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/logger.dart';
import 'package:ombiapp/utils/theme.dart';

class OcneraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logger.d("MAIN APP");
    return MaterialApp(
      theme: AppTheme.theme(context),
      onGenerateRoute: generateRoute,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: AppTheme.APP_BACKGROUND.withOpacity(1),
  // ));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Override default HttpClient to solve SSL problems.
  HttpOverrides.global = MyHttpOverrides();
  //Initialize secure configuration
  await secureStorage.init();
  runApp(OcneraApp());
}
