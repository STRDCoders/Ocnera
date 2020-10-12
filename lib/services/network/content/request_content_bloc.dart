import 'dart:async';

import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_request.dart';
import 'package:ombiapp/model/response/media_content/requests/media_content_request.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class RequestContentBloc {
  final _requestSubject = PublishSubject<MediaContentRequestResponse>();

  Stream<MediaContentRequestResponse> get requestStream =>
      _requestSubject.stream;

  Future<void> requestContent(
      MediaContent content, MediaContentRequest request) async {
    MediaContentRequestResponse res =
        await repo.requestContent(request, content.contentType);
    print(res);
    if (res.statusCode != 200 || res.isError) {
      _requestSubject.sink.addError(res);
      return;
    }

    _requestSubject.sink.add(res);
  }

  void dispose() {
    //TODO - decide whether to call this method or keep stream alive for good.
    _requestSubject.close();
  }
}
