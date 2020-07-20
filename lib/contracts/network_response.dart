abstract class NetworkResponse {
  num _statusCode;

  NetworkResponse(this._statusCode);
  num get statusCode => _statusCode;
//  dynamic getObject();
}