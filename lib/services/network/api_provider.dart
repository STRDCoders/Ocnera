import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:ombiapp/model/response/media_content/movie/movie.dart';
import 'package:ombiapp/model/response/media_content/series/series.dart';
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
      return response.statusCode == 200;
    } on DioError catch (e) {
      return false;
    }
  }

  /// Fetch search results for the given query
  Future<ContentWrapper> contentQuerySearch(
      String query, MediaContentType type) async {
    try {
//      num s = DateTime.now().millisecondsSinceEpoch;
      print("Sending request to: ${type.queryLink}/$query");
      Response res = await _dio.get("${type.queryLink}/$query");
      List<num> content = List();
      //The API sometime returns string when no content found/something unknown happens
      if (res.data is String) return ContentWrapper(200, List());
      //Save only the ID's of the data, everything else will be loaded later with contentIdSearch
      res.data.forEach((e) => {if (e['id'] != 0) content.add(e['id'])});

//      print(
//          "Search job took: ${(DateTime.now().millisecondsSinceEpoch - s) / 1000} seconds");

      return ContentWrapper(200, content);
    } on DioError catch (e) {
      print(e);
      switch (e.type) {
        case DioErrorType.RESPONSE:
          {
            return ContentWrapper(e.response.statusCode, null);
          }
        default:
          {
            return ContentWrapper(-1, null);
          }
          break;
      }
    }
  }

  /// Fetch extended information on the given contentID
  Future<MediaContent> contentIdSearch(
      num contentID, MediaContentType type) async {
    Response res = await _dio.get("${type.infoLink}/$contentID");
    switch (type) {
      case MediaContentType.MOVIE:
        return MovieContent.fromJson(res.data);
        break;
      case MediaContentType.SERIES:
        return SeriesContent.fromJson(res.data);
        break;
    }
  }
}
