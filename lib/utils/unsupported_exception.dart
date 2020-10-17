import 'package:ombiapp/utils/logger.dart';

class UnsupportedException implements Exception {
  String _message;

  UnsupportedException([String message = 'Unsupported Section']) {
    this._message = message;
    logger.e(message);
  }

  @override
  String toString() {
    return _message;
  }
}
