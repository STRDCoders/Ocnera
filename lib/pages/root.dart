import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/pages/login/login_page.dart';
import 'package:ombiapp/pages/login/server_config.dart';
import 'package:ombiapp/pages/page_container.dart';
import 'package:ombiapp/pages/search/search.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/network/identity_bloc.dart';
import 'package:ombiapp/services/secure_storage.dart';

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
//
//class RootPage extends StatefulWidget {
//  @override
//  _RootPageState createState() => _RootPageState();
//}
//
//class _RootPageState extends State<RootPage> {
//
//
//
//  //todo - decide if u want scaffold for each page or just this one and the others will be loaded here.
//  @override
//  Widget build(BuildContext context) {
//    identityBloc.identify();
//    return Container(
//        color: Color.fromARGB(245, 31, 31, 31),
//        child: SafeArea(
//            child: Scaffold(
//                body: Container(
//          child: StreamBuilder(
//            stream: identityBloc.identityStream,
//            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//              switch (snapshot.connectionState) {
//                case ConnectionState.active:
//                  print('active');
//                  if (snapshot.hasError) {
//                    return LoginPage();
//                  } else if (snapshot.hasData) {
//                    print(snapshot.data);
//                    return SearchPage();
//                  }
//                  break;
//                default:
//                  {}
//              }
//              return SpinKitFoldingCube(
//                size: 50,
//                color: Colors.white,
//              );
//            },
//          ),
//        ))));
//  }
//}
