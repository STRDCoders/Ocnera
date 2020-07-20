import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/services/secure_storage.dart';

import 'top_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        TopBar(),
      ],
    );    //    return Column(
//      children: <Widget>[
//        TopBar(),
//        RaisedButton(
//          onPressed: () async{
//            await loginManager.disconnect();
//            RouterService.navigate(context, Routes.ROOT);
//          },
//        ),
//      ],
//    );
  }
}
