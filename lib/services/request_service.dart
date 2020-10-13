import 'dart:async';

import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_request.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/services/network/content/request_content_bloc.dart';
import 'package:ombiapp/services/search_service.dart';

class RequestManager {
  RequestContentBloc _requestContentBloc = RequestContentBloc();

  Stream get requestStream => _requestContentBloc.requestStream;
  StreamSubscription _subscription;

  RequestManager() {
    _subscription = requestStream.listen((data) {
      contentSearchManager.searchItems[data.contentId].contentStatus =
          MediaContentStatus.REQUESTED;
    });
  }

  void requestContent(MediaContent content, MediaContentRequest request) {
    _requestContentBloc.requestContent(content, request);
  }

  void dispose() {
    _subscription.cancel();
  }
}

RequestManager requestManager = RequestManager();
