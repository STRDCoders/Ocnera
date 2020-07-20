import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  User _user;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        backgroundColor: Colors.orange,
        expandedHeight: 150,
        floating: false,
        title: Text("Welcome ${_user.userName}!"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await loginManager.disconnect();
              RouterService.navigate(context, Routes.ROOT);
            },
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
        ));
  }

  @override
  void initState() {
    super.initState();
    this._user = loginManager.user;
  }
}
