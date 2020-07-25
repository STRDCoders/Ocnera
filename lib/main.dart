import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/services/network/http_override.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/theme.dart';

class OmbiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MAIN APP");
    return MaterialApp(
      theme: AppTheme.theme(context),
      onGenerateRoute: generateRoute,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  //TODO - let Amir test this option on his phone.
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Override default HttpClient to solve SSL problems.
  HttpOverrides.global = MyHttpOverrides();
  //Initialize secure configuration
  await secureStorage.init();
  runApp(OmbiApp());
}
