import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/contracts/content_type.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'file:///C:/Users/tomer/AndroidStudioProjects/ombi_app/ombi_app/lib/model/response/content/movie/movie.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

class ApiProvider implements RepositoryAPI {
  Dio _dio;

  ApiProvider() {
    updateDio();
  }

  void updateDio() {
    String url =
        UtilsImpl.buildLink(secureStorage.values[StorageKeys.ADDRESS.value]);
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
      Response response = await _dio.post(
          GlobalConfiguration().getString('API_LINK_LOGIN_LOGIN'),
          data: loginRequestPodo);
      return LoginResponsePodo.fromJson(
          response.data, loginRequestPodo.username);
    } on DioError catch (e) {
      print(e);
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
      Dio tmpClient = Dio();
      tmpClient.options.baseUrl = UtilsImpl.buildLink(address);
      Response response = await tmpClient
          .get(GlobalConfiguration().getString('API_LINK_CONNECTION_TEST'));
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<List<Movie>> searchContent(String query, ContentType type) async {
    switch (type) {
      case ContentType.MOVIE:
        Response res = await _dio.get(GlobalConfiguration().getString(ContentType.MOVIE.value));
        print(res);
        break;
      case ContentType.SERIES:
        // TODO: Handle this case.
        break;
    }
  }
}
