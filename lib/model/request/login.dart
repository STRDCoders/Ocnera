class LoginRequestPodo {
  String username, password, address;
  bool rememberMe;
  bool usePlexOAuth;

  LoginRequestPodo(this.address, this.username, this.password, this.rememberMe, this.usePlexOAuth);


  Map<String, dynamic> toJson() =>
      {
        'address': address,
        'username': username,
        'password': password,
        'rememberMe': rememberMe,
        'usePlexOAuth': usePlexOAuth
      };

}