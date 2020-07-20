import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitTextInputFormatter extends TextInputFormatter {
  final num _min;
  final num _max;

  DigitTextInputFormatter(this._min, this._max);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) {
    int val = int.parse(newValue.text);
    if(newValue.text == '')
      return TextEditingValue().copyWith(text: _min.toString());
    else if(val < _min)
      return TextEditingValue().copyWith(text: _min.toString());

    return val > _max ? TextEditingValue().copyWith(text:(val%10).toString()) : newValue;
  }
}
