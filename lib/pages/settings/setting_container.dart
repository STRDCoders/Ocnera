import 'package:flutter/material.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

class SettingContainer extends StatelessWidget {
  final Icon icon;
  final Widget title, subtitle;
  final Widget input;
  final num inputWidth;

  const SettingContainer(
      {Key key,
      @required this.icon,
      @required this.title,
      this.subtitle,
      @required this.input,
      this.inputWidth: 0.15})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileMoreCustomizable(
        horizontalTitleGap: 0.5,
        leading: icon,
        subtitle: subtitle,
        title: title,
        trailing: Container(
            width: UtilsImpl.getScreenWidth(context) * inputWidth,
            child: input));
  }
}
