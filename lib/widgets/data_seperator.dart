import 'package:flutter/cupertino.dart';

class DataSeparator extends StatelessWidget {
  final Widget child;

  DataSeparator(this.child);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(padding: EdgeInsets.fromLTRB(5, 0, 5, 0), child: Text("•")),
      child
    ]);
  }
}
