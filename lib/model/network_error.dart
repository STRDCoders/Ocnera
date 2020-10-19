import 'package:ocnera/contracts/network_response.dart';

class NetworkError extends NetworkResponse {
  String _message;
  DateTime _date;

  NetworkError(num code, this._message) : super(code) {
    _date = DateTime.now();
  }

  DateTime get date => _date;

  String get message => _message;

  @override
  String toString() {
    return 'NetworkError{_code: $statusCode, _date: $_date}';
  }
}
