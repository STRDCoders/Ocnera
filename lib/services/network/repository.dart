import 'package:flutter/cupertino.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_request.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:ombiapp/model/response/media_content/requests/media_content_request.dart';
import 'package:ombiapp/model/response/user.dart';
import 'package:ombiapp/contracts/media_content_type.dart';

import 'api_provider.dart';

/// Stores all ready API functions. All classes should use this instead of the ApiProvider directly.
///
///

abstract class RepositoryAPI {
  Future<User> getIdentity();
  Future<LoginResponsePodo> login(LoginRequestPodo loginRequestPodo);
  Future<bool> testConnection(String address);
  Future<ContentWrapper> contentSearch ({String query, bool defaultSearch ,@required MediaContentType type});
  Future<MediaContent> contentIdSearch(num contentID, MediaContentType type);
  Future<MediaContentRequestResponse> requestContent(MediaContentRequest request, MediaContentType type);
  void updateDio();
}

RepositoryAPI repo = ApiProvider();