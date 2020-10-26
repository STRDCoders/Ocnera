import 'package:ocnera/contracts/network_response.dart';

class User extends NetworkResponse {
  String _id, _userName, _alias, _email;

  /// User roles map.
  Map<String, bool> _claims = Map();

  User.fromJson(Map<String, dynamic> json) : super(200) {
    this._id = json['id'];
    this._userName = json['userName'];
    this._alias = json['alias'];
    this._email = json['emailAddress'];

    json['claims']
        .forEach((claim) => {_claims[claim['value']] = claim['enabled']});
  }

  User(num code) : super(code);

  Map<String, bool> get claims => _claims;

  get email => _email;

  get alias => _alias;

  String get userName => _userName;

  String get id => _id;

  @override
  String toString() {
    return 'User{_status: $statusCode, _id: $_id, _userName: $_userName, _alias: $_alias, _email: $_email, _claims: $_claims}';
  }
}
