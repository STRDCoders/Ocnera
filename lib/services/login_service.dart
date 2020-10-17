import 'dart:async';

import 'package:ombiapp/model/response/login_response.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/logger.dart';

import 'network/authorization/identity_bloc.dart';
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
    });
  }

  Future<void> saveAddress(String address) async {
    logger.d("Saving $address");
    await secureStorage.saveData(StorageKeys.ADDRESS.value, address);
    repo.updateDio();
  }

  /// In case the user wants to disconnect from the server, remove all saved data.
  ///
  Future<void> removeAddress() async {
    await secureStorage.removeAllData();
  }

  Future<void> login(LoginResponseDto loginResponsePodo) async {
    await secureStorage.saveData(
        StorageKeys.TOKEN.value, loginResponsePodo.key);
    await secureStorage.saveData(
        StorageKeys.USERNAME.value, loginResponsePodo.username);
    repo.updateDio();
  }

  Future<void> disconnect() async {
    await secureStorage.removeData(StorageKeys.TOKEN.value);
    repo.updateDio();
  }

  void identify() {
    _identityBloc.identify();
  }

  bool isServerConfigured() {
    return secureStorage.values[StorageKeys.ADDRESS.value] != null;
  }

  void dispose() {
    _sub.cancel();
  }

  User get user => _user;

  Stream<User> get identityStream => _identityBloc.identityStream;
}

final LoginService loginManager = LoginService();
