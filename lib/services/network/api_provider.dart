import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_request.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/model/request/login_request.dart';
import 'package:ombiapp/model/response/login_response.dart';
import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:ombiapp/model/response/media_content/movie/movie.dart';
import 'package:ombiapp/model/response/media_content/requests/media_content_request_response.dart';
import 'package:ombiapp/model/response/media_content/series/series.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/logger.dart';
import 'package:ombiapp/utils/unsupported_exception.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

class ApiProvider implements RepositoryAPI {
  Dio _dio;

  ApiProvider() {
    updateDio();
  }

  BaseOptions fetchBaseOptions(String url) {
    BaseOptions options = new BaseOptions(
        baseUrl: url,
        connectTimeout: 8000,
        receiveTimeout: 8000,
        sendTimeout: 8000,
        headers: {
          'Content-Type': "application/json-patch+json",
          'Authorization':
              "Bearer ${secureStorage.values[StorageKeys.TOKEN.value]}"
        });
    return options;
  }

  void updateDio() {
    String url =
        UtilsImpl.buildLink(secureStorage.values[StorageKeys.ADDRESS.value]);
    print("Dio Using IP: $url");
    this._dio = new Dio(fetchBaseOptions(url));
  }

  Future<LoginResponseDto> login(LoginRequest loginRequestPodo) async {
    try {
      print(
          "Logging in.. using link: ${GlobalConfiguration().getValue('API_LINK_LOGIN_LOGIN')}");
      Response response = await _dio.post(
          GlobalConfiguration().getValue('API_LINK_LOGIN_LOGIN'),
          data: loginRequestPodo);
      return LoginResponseDto.fromJson(
          response.data, loginRequestPodo.username);
    } on DioError catch (e) {
      print(e);
      switch (e.type) {
        case DioErrorType.RESPONSE:
          {
            return LoginResponseDto(e.response.statusCode);
          }
        default:
          {
            return LoginResponseDto(-1);
          }
          break;
      }
    }
  }

  Future<User> getIdentity() async {
    try {
      Response response = await _dio
          .get(GlobalConfiguration().getValue('API_LINK_IDENTITY_CURRENT'));
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
      Dio tmpClient = Dio(fetchBaseOptions(address));
      tmpClient.options.baseUrl = UtilsImpl.buildLink(address);
      Response response = await tmpClient
          .get(GlobalConfiguration().getValue('API_LINK_CONNECTION_TEST'));
      return response.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  /// Fetch search results for the given parameters.
  ///
  /// if [defaultSearch] set to true, a request will be sent to the default content link of the [type] without any parameters.
  /// else, a search request for the [query] will be sent to the corresponding [type] link.
  ///
  Future<ContentWrapper> contentSearch(
      {String query,
      bool defaultSearch = false,
      @required MediaContentType type}) async {
    try {
      Response res;
      if (defaultSearch)
        res = await _dio.get(type.defaultContentLink);
      else
        res = await _dio.get("${type.queryLink}/$query");
      List<num> content = List();
      //The API sometime returns string when no content found/something unknown happens
      if (res.data is String) return ContentWrapper(200, List());
      //Save only the ID's of the data, everything else will be loaded later with contentIdSearch
      res.data.forEach((e) => {if (e['id'] != 0) content.add(e['id'])});

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
    if (res.statusCode != 200) {
      logger.e(
          "Content search: $contentID($type) returned status code: ${res.statusCode}");
      return null;
    }
    switch (type) {
      case MediaContentType.MOVIE:
        return MovieContent.fromJson(res.data);
        break;
      case MediaContentType.SERIES:
        return SeriesContent.fromJson(res.data);
        break;
      default:
        throw UnsupportedException();
    }
  }

  /// Sends a request to the API for new content request.
  Future<MediaContentRequestResponse> requestContent(
      MediaContentRequest request, MediaContentType type) async {
    try {
      Response response =
          await _dio.post(type.requestLink, data: request.toJson());
      print(response.data);
      return MediaContentRequestResponse.fromJson(response.data, request.id);
    } on DioError catch (e) {
      print(e);
      switch (e.type) {
        case DioErrorType.RESPONSE:
          {
            return MediaContentRequestResponse(e.response.statusCode);
          }
        default:
          {
            return MediaContentRequestResponse(-1);
          }
          break;
      }
    }
  }
}
