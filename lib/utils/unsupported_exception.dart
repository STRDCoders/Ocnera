import 'package:ocnera/utils/logger.dart';

class UnsupportedException implements Exception {
  String _message;

  UnsupportedException([String message = 'Unsupported Section']) {
    this._message = message;
    appLogger.log(LoggerTypes.ERROR, message);
  }

  @override
  String toString() {
    return _message;
  }
}
