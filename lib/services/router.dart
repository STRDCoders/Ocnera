import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/pages/error.dart';
import 'package:ombiapp/pages/login/login_page.dart';
import 'package:ombiapp/pages/page_container.dart';
import 'package:ombiapp/pages/root.dart';
import 'package:ombiapp/pages/search/search.dart';

enum Routes { ROOT, LOGIN, SETTINGS, SEARCH }

extension RoutesExtension on Routes {
  static String _value(Routes val) {
    switch (val) {
      case Routes.LOGIN:
        return '/intro';
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
    }
  }

  String get value => _value(this);
}

class RouterService {

  static navigate(context, Routes route) {
    switch (route) {
      case Routes.LOGIN:
        Navigator.popAndPushNamed(context, Routes.LOGIN.value);
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
    }
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  // Using if/else instead of switch/case since case expressions must be constant, which is not the case
  if (settings.name == Routes.ROOT.value || settings.name == "/")
    return MaterialPageRoute(builder: (context) => RootPage());
  else if (settings.name == Routes.LOGIN.value)
    return MaterialPageRoute(builder: (context) => PageContainer(LoginPage()));
  else if (settings.name == Routes.SEARCH.value)
    return MaterialPageRoute(builder: (context) => PageContainer(SearchPage()));

  return MaterialPageRoute(builder: (context) => PageContainer(ErrorPage()));
}
