import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/utils/extentions.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  User _user;
  GlobalKey btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Color.fromARGB(240, 31, 31, 31),
      floating: true,
      titleSpacing: 0,
      snap: true,
      title: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                    hintText: "Search..",
                    //TODO - The values should be of enum "ContentType" instead of string.
                    prefixIcon: IconButton(
                      icon: Icon(Icons.movie),
                      color: Colors.white,
                      onPressed: () {
                        PopupMenuButton<String>(itemBuilder: (BuildContext context) {
                          List<PopupMenuItem<String>> list = List();
                          list.add(PopupMenuItem<String>(
                            value: "Test", child: Text("test"),));
                          return list;
                        }, onSelected: (e) {print('test');});
                      },
                    )),
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      actions: <Widget>[],
      centerTitle: true,
    );
  }

  @override
  void initState() {
    super.initState();
    this._user = loginManager.user;
  }
}
