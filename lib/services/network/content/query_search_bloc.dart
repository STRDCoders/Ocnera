import 'package:flutter/material.dart';
import 'package:ocnera/contracts/media_content.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/model/network_error.dart';
import 'package:ocnera/model/response/media_content/content_wrapper.dart';
import 'package:ocnera/services/network/repository.dart';
import 'package:ocnera/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class QuerySearchBloc {
  final _searchSubject = PublishSubject<MediaContent>();

  //Notify the subscribers when a search job is finished.
  final _searching = PublishSubject<bool>();

  Stream<MediaContent> get searchStream => _searchSubject.stream;

  Stream<bool> get isSearching => _searching.stream;

  /// Sends a search request either by user's query, or by default content link.
  ///
  /// The function may get a [query] to be searched, or [defaultContent] to get content of [type]. Either way,
  /// the API requires to send 1 request to fetch all of the content id's, and 1 request per id to fetch extra information
  /// The function will wait for all of the requests to finish before returning any value.
  ///
  Future<void> search(
      {String query,
      bool defaultContent = false,
      @required MediaContentType type}) async {
    _searching.sink.add(true);
    num s = DateTime.now().millisecondsSinceEpoch;
    logger.d("Searching for query: $query");
    ContentWrapper res;

    res = await repo.contentSearch(
        query: query, defaultSearch: defaultContent, type: type);
    switch (res.statusCode) {
      case 200:
        {
          // Since there contentID.length requests to send, we want to send them simultaneously to avoid long wait time.
          List<MediaContent> contentLise = await Future.wait(res.contentID
              .map((itemId) => repo.contentIdSearch(itemId, type)));

          for (MediaContent content in contentLise) {
            // Some content items may be broken when fetching extended information.
            // Therefor they need to be skipped.
            if (content == null || content.id == 0) continue;
            _searchSubject.sink.add(content);
          }
          _searching.sink.add(false);
          logger.d(
              "Search job took: ${(DateTime.now().millisecondsSinceEpoch - s) / 1000} seconds");
        }
        break;
      case 401:
        {
          _searchSubject.sink.addError(NetworkError(
              res.statusCode, "One of the credentials is incorrect!"));
        }
        break;
      default:
        {
          _searchSubject.sink.addError(
              NetworkError(res.statusCode, "An unknown error has occurred."));
        }
    }
  }

  dispose() {
    print('disposing identify stream');
    _searchSubject.close();
    _searching.close();
  }
}
