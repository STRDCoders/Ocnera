import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/pages/login/login_page.dart';
import 'package:ombiapp/pages/root.dart';
import 'package:ombiapp/pages/search/search.dart';
import 'package:ombiapp/services/network/http_override.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/services/secure_storage.dart';

class OmbiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MAIN APP");
    return MaterialApp(
      theme: ThemeData(
          buttonTheme: ButtonThemeData(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(secondary: Colors.white),
              buttonColor: Colors.orange,
              textTheme: ButtonTextTheme.accent),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          scaffoldBackgroundColor: const Color.fromARGB(245, 31, 31, 31)),
      initialRoute: Routes.ROOT.value,
      onGenerateRoute: generateRoute,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");

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
