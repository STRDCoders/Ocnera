import 'package:flutter/material.dart';
import 'package:ocnera/widgets/drawer.dart';

/// Widget template for the basic app layout.
///
///
class PageContainer extends StatelessWidget {
  final Widget _widget;
  final bool resizable;
  final Widget appbar;
  final bool safeAreaTop;

  PageContainer(this._widget,
      {this.resizable: false, this.appbar, this.safeAreaTop: true});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(245, 31, 31, 31),
        child: SafeArea(
            bottom: false,
            top: this.safeAreaTop,
            child: Scaffold(
                appBar: appbar,
                drawer: AppDrawer(),
                resizeToAvoidBottomInset: resizable,
                body: _widget)));
  }
}
