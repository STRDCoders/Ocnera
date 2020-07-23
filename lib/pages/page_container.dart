import 'package:flutter/material.dart';
import 'package:ombiapp/widgets/drawer.dart';

/// Widget template for the basic app layout.
///
///
class PageContainer extends StatelessWidget {
  final Widget _widget;
  bool resizable = false;
  Widget appbar;

  PageContainer(this._widget, {resizable, appbar});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(245, 31, 31, 31),
        child: SafeArea(
            child: Scaffold(
                appBar: appbar,
//                bottomNavigationBar: BottomNavigationBar(
//                  items: const <BottomNavigationBarItem>[
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.home),
//                      title: Text('Home'),
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.business),
//                      title: Text('Business'),
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.school),
//                      title: Text('School'),
//                    ),
//                  ],
//                  currentIndex: 0,
//                  selectedItemColor: Colors.amber[800],
//                  onTap: (e){},
//                ),
                drawer: AppDrawer(),
                resizeToAvoidBottomInset: resizable,
                body: _widget)));
  }
}
