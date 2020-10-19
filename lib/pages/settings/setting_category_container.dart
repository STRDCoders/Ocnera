import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/pages/settings/setting_container.dart';

class SettingCategoryContainer extends StatelessWidget {
  final String title;
  final List<SettingContainer> settings;

  const SettingCategoryContainer(
      {Key key, @required this.title, @required this.settings})
      : assert(settings != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 8),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w400),
                )),
            ...settings
          ],
        ));
  }
}
