class TokenRefreshRequest {
  String _token, _username;

  TokenRefreshRequest(this._token, this._username);

  Map<String, dynamic> toJson() => {
        'token': _token,
        'username': _username,
      };
}
