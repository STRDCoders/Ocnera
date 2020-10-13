import 'package:ombiapp/contracts/network_response.dart';

class LoginResponsePodo extends NetworkResponse {
  String _username;
  String _key;
  String _expireDate;

  LoginResponsePodo.fromJson(Map<String, dynamic> json, this._username)
      : super(200) {
    this._key = json['access_token'];
    this._expireDate = json['expirtation'];
  }

  LoginResponsePodo(num status) : super(status);

  @override
  String toString() {
    return 'LoginResponsePodo{_statusCode: $statusCode, _key: $_key, _expireDate: $_expireDate, _username: $_username}';
  }

  String get username => _username;

  String get key => _key;

  String get expireDate => _expireDate;

// @override
// getObject() {
//   // TODO: implement getObject
//   throw UnimplementedError();
// }
}
