import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/pages/page_container.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/utils/logger.dart';

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
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => RouterService.navigate(context, Routes.SERVER_LOGIN));
    return StreamBuilder(
        stream: loginManager.identityStream,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => RouterService.navigate(context, Routes.LOGIN));
              } else if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => RouterService.navigate(context, Routes.SEARCH));
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
    logger.d('init root ');
    super.initState();
    if (loginManager.isServerConfigured()) loginManager.identify();
  }

  @override
  void dispose() {
    super.dispose();
    logger.d('disposing root');
  }
}
