import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/model/network_error.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/request/token_refresh.dart';
import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:ombiapp/services/secure_storage.dart';

class ApiProvider implements RepositoryAPI{
  Dio _dio;

  ApiProvider() {
    updateDio();
  }

  void updateDio() {
    String url =
        "${GlobalConfiguration().getString('API_ADDRESS_PREFIX')}${secureStorage.values[StorageKeys.ADDRESS]}${GlobalConfiguration().getString('API_ADDRESS_SUFFIX')}";
    print("Dio Using IP: $url");
    BaseOptions options = new BaseOptions(
        baseUrl: url,
        connectTimeout: 8000,
        receiveTimeout: 8000,
        headers: {
          'Content-Type': "application/json-patch+json",
          'Authorization':
              "Bearer ${secureStorage.values[StorageKeys.TOKEN.value]}"
        });
    this._dio = new Dio(options);
  }

  Future<LoginResponsePodo> login(LoginRequestPodo loginRequestPodo) async {
    try {
      print(
          "Logging in.. using link: ${GlobalConfiguration().getString('API_LINK_LOGIN_LOGIN')}");
      _dio.options.baseUrl = loginRequestPodo.address;
      Response response = await _dio.post(
          GlobalConfiguration().getString('API_LINK_LOGIN_LOGIN'),
          data: loginRequestPodo);
      return LoginResponsePodo.fromJson(
          response.data, loginRequestPodo.username);
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.RESPONSE:
          {
            return LoginResponsePodo(e.response.statusCode);
          }
        default:
          {
            return LoginResponsePodo(-1);
          }
          break;
      }

    }
  }

  Future<User> getIdentity() async {
    try {
      Response response = await _dio
          .get(GlobalConfiguration().getString('API_LINK_IDENTITY_CURRENT'));
      return User.fromJson(response.data);
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.RESPONSE:
          {
            return User(e.response.statusCode);
          }
        default:
          {
            return User(-1);
          }
          break;
      }
    }
  }

  Future<bool> testConnection(String address) async {
    try {
      Response response = await _dio
          .get(GlobalConfiguration().getString('API_LINK_CONNECTION_TEST'));
      return true;
    } on DioError catch (e) {
      return false;
    }
    }

}
