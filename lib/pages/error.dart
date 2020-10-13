import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.warning,
          size: 150,
          color: Colors.orangeAccent,
        ),
        Text(
          "Well that's Awkward but.. You should not be here.",
          style: TextStyle(fontSize: 17),
        ),
        Text("I probably messed up somewhere, like I always do...")
      ],
    ));
  }
}
