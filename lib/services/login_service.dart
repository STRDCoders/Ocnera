import 'dart:async';

import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/network/identity_bloc.dart';
import 'package:ombiapp/services/secure_storage.dart';

import 'network/repository.dart';

/// Responsible for Login system logic.
///
class LoginService {
  User _user;
  final IdentityBloc _identityBloc = IdentityBloc();
  StreamSubscription _sub;

  LoginService() {
    _sub = _identityBloc.identityStream.listen((event) {
      this._user = event;
      print("HEY $_user");
    });
  }

  Future<void> login(LoginResponsePodo loginResponsePodo) async {
    await secureStorage.saveData(
        StorageKeys.TOKEN.value, loginResponsePodo.key);
    await secureStorage.saveData(StorageKeys.USERNAME.value, loginResponsePodo.username);
    repo.updateDio();
  }

  Future<void> disconnect() async {
    secureStorage.removeData(StorageKeys.TOKEN.value);
    await secureStorage.removeData(StorageKeys.TOKEN.value);
    repo.updateDio();
  }

  void identify() {
    _identityBloc.identify();
  }

  void dispose() {
    _sub.cancel();
  }

  User get user => _user;

  Stream<User> get identityStream => _identityBloc.identityStream;
}

final LoginService loginManager = LoginService();
