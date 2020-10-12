import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ombiapp/utils/theme.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

class CardTemplate extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double ratio;
  const CardTemplate(
      {Key key,
      @required this.child,
      @required this.onTap,
      @required this.ratio})
      : super(key: key);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
            height: UtilsImpl.getScreenHeight(context, true) *
                ((widget.ratio < 1.8) ? 0.35 : 0.30),
            child: InkWell(
                onTap: widget.onTap,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: AppTheme.DATA_BACKGROUND,
                    child: ClipRect(
                        child: BackdropFilter(
                            filter:
                                new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: new Container(
                                color: AppTheme.APP_BACKGROUND.withOpacity(0.5),
                                child: widget.child)))))));
  }
}
