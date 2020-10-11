import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/pages/media_content/content_page.dart';
import 'package:ombiapp/pages/error.dart';
import 'package:ombiapp/pages/login/login_page.dart';
import 'package:ombiapp/pages/login/server_config.dart';
import 'package:ombiapp/pages/media_content/series_request/series_request_page.dart';
import 'package:ombiapp/pages/page_container.dart';
import 'package:ombiapp/pages/root.dart';
import 'package:ombiapp/pages/search/search.dart';
import 'package:ombiapp/pages/settings/settings_page.dart';

enum Routes { ROOT, LOGIN, SETTINGS, SEARCH, MEDIA_CONTENT, SERVER_LOGIN, SERIES_REQUEST }

extension RoutesExtension on Routes {
  static String _value(Routes val) {
    switch (val) {
      case Routes.LOGIN:
        return '/login';
        break;
      case Routes.SETTINGS:
        return '/settings';
        break;
      case Routes.SEARCH:
        return '/index/search';
        break;
      case Routes.ROOT:
        return '/root';
        break;
      case Routes.MEDIA_CONTENT:
        return '/movie';
        break;
      case Routes.SERVER_LOGIN:
        return '/login/server';
        break;
      case Routes.SERIES_REQUEST:
        return '/request/series/new';
    }
  }

  String get value => _value(this);
}

class RouterService {

  static navigate(context, Routes route, {dynamic data}) {
    switch (route) {
      case Routes.LOGIN:
        Navigator.popAndPushNamed(context, Routes.LOGIN.value);
        break;
      case Routes.SERVER_LOGIN:
        Navigator.popAndPushNamed(context, Routes.SERVER_LOGIN.value);
        break;
      case Routes.SETTINGS:
        Navigator.popAndPushNamed(context, Routes.SETTINGS.value);
        break;
      case Routes.SEARCH:
        Navigator.popAndPushNamed(context, Routes.SEARCH.value);
        break;
      case Routes.ROOT:
        Navigator.popAndPushNamed(context, Routes.ROOT.value);
        break;
      case Routes.MEDIA_CONTENT:
        Navigator.pushNamed(context, Routes.MEDIA_CONTENT.value, arguments: data);
        break;
      case Routes.SERIES_REQUEST:
        Navigator.pushNamed(context, Routes.SERIES_REQUEST.value, arguments: data);
    }
  }
}

/// Register routes to main app
Route<dynamic> generateRoute(RouteSettings settings) {
  print("Routing to: ${settings.name}");
  // Using if/else instead of switch/case since case expressions must be constant, which is not the case
  if (settings.name == Routes.ROOT.value || settings.name == "/")
    return MaterialPageRoute(builder: (context) => RootPage());
  else if (settings.name == Routes.LOGIN.value)
    return MaterialPageRoute(builder: (context) => PageContainer(LoginPage()));
  else if (settings.name == Routes.SEARCH.value)
    return MaterialPageRoute(builder: (context) => PageContainer(SearchPage(),safeAreaTop: false,));
  else if(settings.name == Routes.MEDIA_CONTENT.value)
    return MaterialPageRoute(builder: (context) => PageContainer(MovieContentPage(data:settings.arguments), ));
  else if(settings.name == Routes.SERVER_LOGIN.value)
    return MaterialPageRoute(builder: (context) => PageContainer(ServerConfig()));
  else if(settings.name == Routes.SERIES_REQUEST.value)
    return MaterialPageRoute(builder: (context) => (SeriesRequestPage(seriesContent: settings.arguments,)));
  else if(settings.name == Routes.SETTINGS.value)
    return MaterialPageRoute(builder: (context) => PageContainer(SettingsPage()));
    return MaterialPageRoute(builder: (context) => PageContainer(ErrorPage()));
}
