import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/request/token_refresh.dart';
import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'package:ombiapp/model/response/user.dart';

import 'api_provider.dart';

/// Stores all ready API functions. All classes should use this instead of the ApiProvider directly.
///
///

abstract class RepositoryAPI {
  Future<User> getIdentity();
  Future<LoginResponsePodo> login(LoginRequestPodo loginRequestPodo);
  Future<bool> testConnection(String address);
  void updateDio();
}

RepositoryAPI repo = ApiProvider();