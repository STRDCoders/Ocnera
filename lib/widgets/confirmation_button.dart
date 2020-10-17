import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ombiapp/utils/theme.dart';

class ConfirmButton extends StatefulWidget {
  final Widget title;
  final Widget confirmationTitle;
  final Function onPressed;
  final int confirmResetDelay;

  const ConfirmButton(
      {Key key,
      @required this.title,
      @required this.confirmationTitle,
      @required this.onPressed,
      this.confirmResetDelay: 1})
      : super(key: key);

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  bool confirmed;
  Timer timer;

  @override
  void initState() {
    confirmed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: confirmed ? widget.confirmationTitle : widget.title,
      onPressed: handleSubmit,
      color: this.confirmed ? Colors.red : AppTheme.BUTTON_COLOR,
    );
  }

  void initTimer() {
    timer = Timer(Duration(milliseconds: widget.confirmResetDelay * 1000), () {
      setState(() {
        confirmed = !confirmed;
      });
    });
  }

  void handleSubmit() {
    if (confirmed) {
      widget.onPressed();
      timer?.cancel();
    } else {
      initTimer();
    }
    setState(() {
      confirmed = !confirmed;
    });
  }
}
