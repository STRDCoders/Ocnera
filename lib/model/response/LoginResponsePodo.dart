class LoginResponsePodo {
  num _statusCode;
  String _key;
  String _expireDate;

  LoginResponsePodo.fromJson(Map<String, dynamic> json) {
    this._statusCode = 200;
    this._key = json['access_token'];
    this._expireDate = json['expirtation'];
  }

  LoginResponsePodo(this._statusCode);



  @override
  String toString() {
    return 'LoginResponsePodo{_statusCode: $_statusCode, _key: $_key, _expireDate: $_expireDate}';
  }

  num get statusCode => _statusCode;

  String get key => _key;

  String get expireDate => _expireDate;


}
