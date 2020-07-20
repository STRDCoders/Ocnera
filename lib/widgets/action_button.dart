//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//
/////
///// An extension for the regular RaisedButton widget.
///// This extension gives you the option to set the state of the button as disabled
///// when preforming some action.
/////
//class ActionButton extends StatelessWidget {
//  final bool _loading;
//  final Function _callback;
//  final Widget _child;
//
//  ActionButton(this._loading, this._callback, this._child);
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(
//      onPressed: _loading ? null : _callback,
//      color: Colors.orange,
//      textColor: Colors.white,
//      child: _loading
//          ? Container(
//              child: CircularProgressIndicator())
//          : _child,
//    );
//  }
//}
