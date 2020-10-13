import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/router.dart';
import 'package:ombiapp/utils/theme.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      decoration: BoxDecoration(
        color: AppTheme.APP_BACKGROUND.withAlpha(255),
      ),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.APP_BACKGROUND,
              border: Border(
                bottom: BorderSide(width: 0.5, color: AppTheme.DATA_BACKGROUND),
              ),
            ),
            otherAccountsPictures: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  print('pressed');
                  await loginManager.disconnect();
                  Navigator.of(context)
                      .pop(); // Pop the Drawer itself before passing the page context to navigator.
                  RouterService.navigate(context, Routes.ROOT);
                },
              )
            ],
            accountName: Text(
              loginManager.user.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              loginManager.user?.email,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.white70,
            ),
            title: Text('Search Page'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              RouterService.navigate(context, Routes.SEARCH);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white70,
            ),
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              RouterService.navigate(context, Routes.SETTINGS);
            },
          ),
        ],
      ),
    ));
  }
}
