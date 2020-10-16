import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {
  final Icon icon;
  final String text;

  const PopupItem({Key key, @required this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 10,
        ),
        Text(text)
      ],
    );
  }
}
