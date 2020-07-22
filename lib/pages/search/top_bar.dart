import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/pages/search/profile_menu.dart';
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
      backgroundColor: Color.fromARGB(255, 31, 31, 31),
      floating: true,
      snap: true,
      // Add this code
      leading: IconButton(
        key: btnKey,
        onPressed: (){
          //TODO - Fix the menu not showing.
          ProfileMenuPage(key: btnKey);
        },
          icon: Icon(
        CupertinoIcons.profile_circled,
        color: Colors.white,
      )),
      title: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            cursorColor: Colors.orange,
            decoration:
                InputDecoration(hintText: "Search.."),
                style: TextStyle(color: Colors.grey),
          ))
        ],
      ),
      actions: <Widget>[
        //TODO - Move this button to a menu bar that will appear upon clicking the profile image.
//        IconButton(
//          icon: Icon(Icons.exit_to_app),
//          onPressed: () async {
//            await loginManager.disconnect();
//            RouterService.navigate(context, Routes.ROOT);
//          },
//        )
      ],
//      bottom: PreferredSize(                       // Add this code
//        preferredSize: Size.fromHeight(60.0),      // Add this code
//        child: Text(''),                           // Add this code
//      ),
//      flexibleSpace: FlexibleSpaceBar(
//        background: Column(
//          children: <Widget>[
//          SizedBox(height: 50,),
//            Expanded(child: SearchBar(
//              hintText: "Search...",
//              iconActiveColor: Colors.white12,
//              textStyle: TextStyle(decoration: TextDecoration.none, color: Colors.white),
//              searchBarPadding: EdgeInsets.symmetric(horizontal: 5),
//              listPadding: EdgeInsets.symmetric(horizontal: 5),
//              searchBarStyle: SearchBarStyle(backgroundColor: Colors.white30),
//            ),),
//          ],
//        ),
//      ),

//          Flexible(child:Container(padding: EdgeInsets.all(10),child:SearchBar(searchBarStyle: SearchBarStyle(backgroundColor: Colors.white30),))),
      centerTitle: true,
    );
  }

  @override
  void initState() {
    super.initState();
    this._user = loginManager.user;
  }
}
