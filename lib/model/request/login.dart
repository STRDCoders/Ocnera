class LoginRequestPodo {
  String username, password;
  bool rememberMe;
  bool usePlexOAuth;

  LoginRequestPodo(
      this.username, this.password, this.rememberMe, this.usePlexOAuth);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'rememberMe': rememberMe,
        'usePlexOAuth': usePlexOAuth
      };
}
