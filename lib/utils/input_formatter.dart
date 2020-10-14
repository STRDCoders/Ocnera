import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitTextInputFormatter extends TextInputFormatter {
  final num _min;
  final num _max;

  DigitTextInputFormatter(this._min, this._max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int val = int.parse(newValue.text);
    if (newValue.text == '' || val < _min || val > _max) return oldValue;
    return newValue;
  }
}
