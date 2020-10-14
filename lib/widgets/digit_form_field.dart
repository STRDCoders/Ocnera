import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ombiapp/utils/input_formatter.dart';

class DigitInputField extends StatefulWidget {
  final TextEditingController controller;
  final DigitTextInputFormatter formatter;
  final InputDecoration decoration;
  final void Function(String) callback ;
  const DigitInputField(
      {Key key,
        @required this.controller,
        @required this.formatter,
        @required this.decoration,
        this.callback})
      : super(key: key);

  @override
  _DigitInputFieldState createState() => _DigitInputFieldState();
}

class _DigitInputFieldState extends State<DigitInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textDirection: TextDirection.ltr,
        onFieldSubmitted: widget.callback,
        textAlign: TextAlign.center,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp(r"\d+$")),
          widget.formatter
        ],
        decoration: widget.decoration);
  }
}
