import 'package:flutter/material.dart';

/// Widget template for the basic app layout.
///
///
class PageContainer extends StatelessWidget {
  final Widget _widget;
  bool resizable = false;
  PageContainer(this._widget, {resizable});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(245, 31, 31, 31),
        child: SafeArea(child: Scaffold(
            resizeToAvoidBottomInset: resizable,
            body: _widget)));
  }
}
