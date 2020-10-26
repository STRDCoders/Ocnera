import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ocnera/model/response/user.dart';
import 'package:ocnera/pages/page_container.dart';
import 'package:ocnera/services/login_service.dart';
import 'package:ocnera/services/router.dart';

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
                print('Switching to Login page');
                WidgetsBinding.instance.addPostFrameCallback(
                        (_) => RouterService.navigate(context, Routes.LOGIN));
              } else if (snapshot.hasData) {
                print('Switching to Search Page');
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
                  'LOADING'.tr(),
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
