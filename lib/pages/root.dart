import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/pages/login/login_page.dart';
import 'package:ombiapp/pages/login/server_config.dart';
import 'package:ombiapp/pages/page_container.dart';
import 'package:ombiapp/pages/search/search.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';

///
/// This widget determines whether the user is logged in,
/// and therefor which screen should be shown.
///

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    if (!loginManager.isServerConfigured())
      WidgetsBinding.instance.addPostFrameCallback((_) =>RouterService.navigate(context, Routes.SERVER_LOGIN));
    print("building");
    return StreamBuilder(
        stream: loginManager.identityStream,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.hasError) {
                print('Switching to Login page');
//                return PageContainer(LoginPage());
                WidgetsBinding.instance.addPostFrameCallback((_) =>RouterService.navigate(context, Routes.LOGIN));
              } else if (snapshot.hasData) {
                print('Switching to Search Page');
//                return PageContainer(SearchPage());
                WidgetsBinding.instance.addPostFrameCallback((_) =>RouterService.navigate(context, Routes.SEARCH));

              }
              break;
            default:
              {}
          }
          return PageContainer(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitFoldingCube(
                  size: 70,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )
              ]));
        });
  }

  @override
  void initState() {
    print('init root ');
    super.initState();
    if (loginManager.isServerConfigured()) loginManager.identify();
  }

  @override
  void dispose() {
    super.dispose();
    print('disposing root');
  }
}
