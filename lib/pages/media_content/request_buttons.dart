import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {

  final String text;
  final Color color;

  const StatusButton ({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 15,
      disabledColor: color,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
            fontSize: 12),
      ),
    );
  }
}

class RequestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 15,
      color: Colors.cyan,
      child: Text(
        "Request",
        style: TextStyle(
            fontSize: 12),
      ),
      onPressed: () {},
    );  }
}

