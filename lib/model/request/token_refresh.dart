class TokenRefreshRequestPodo {
  String _token, _username;

  TokenRefreshRequestPodo(this._token, this._username);

  Map<String, dynamic> toJson() => {
        'token': _token,
        'username': _username,
      };
}
