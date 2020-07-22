import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

class ProfileMenuPage extends StatefulWidget {
  final GlobalKey btnKey;

  const ProfileMenuPage({
    Key key,
    @required this.btnKey,
  }) : super(key: key);


  @override
  _ProfileMenuPageState createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  PopupMenu menu;


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    PopupMenu(items: [
      // MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
      // MenuItem(title: 'Home', image: Icon(Icons.home, color: Colors.white,)),
      MenuItem(
          title: 'Mail',
          image: Icon(
            Icons.mail,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Exit',
          image: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          )),
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 2);
    PopupMenu.context = context;
    menu.show(widgetKey: widget.btnKey);
  }

  void onClickMenu(MenuItemProvider item) {}

  void onDismiss() {}
}
