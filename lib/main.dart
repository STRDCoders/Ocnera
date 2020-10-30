import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ocnera/services/local_settings.dart';
import 'package:ocnera/services/network/http_override.dart';
import 'package:ocnera/services/router.dart';
import 'package:ocnera/services/secure_storage_service.dart';
import 'package:ocnera/utils/logger.dart';
import 'package:ocnera/utils/theme.dart';

class OcneraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logger.d('MAIN APP');
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.theme(context),
      onGenerateRoute: generateRoute,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('config');
  await configureLogger();
  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e("Error caught @flutter: ${details.exception}\n${details.stack}");
  };
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

  await secureStorage.init();
  await localSettings.init();

  // runApp(OcneraApp());
  runApp(EasyLocalization(
      supportedLocales: [Locale('he', 'IL'), Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: OcneraApp()));
}
