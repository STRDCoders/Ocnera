import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/pages/login/login_page.dart';
import 'package:ombiapp/pages/login/server_config.dart';
import 'package:ombiapp/pages/page_container.dart';
import 'package:ombiapp/pages/search/search.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/network/identity_bloc.dart';
import 'package:ombiapp/services/secure_storage_service.dart';

///
/// This widget determines whether the user is logged in,
/// and therefor which screen should be shown.
///

class RootPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if(secureStorage.values[StorageKeys.ADDRESS.value] == null)
      return PageContainer(ServerConfig(), resizable: false,);

    loginManager.identify();
    return StreamBuilder(
        stream: loginManager.identityStream,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.hasError) {
                return PageContainer(LoginPage());
              } else if (snapshot.hasData) {
                return PageContainer(SearchPage());
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
}