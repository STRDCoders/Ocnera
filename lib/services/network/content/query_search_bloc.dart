import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/model/network_error.dart';
import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class QuerySearchBloc {
  final _searchSubject = PublishSubject<MediaContent>();

  //Notify the subscribers when a search job is finished.
  final _searching = PublishSubject<bool>();

  Stream<MediaContent> get searchStream => _searchSubject.stream;

  Stream<bool> get isSearching => _searching.stream;

  Future<void> search(String query, MediaContentType type) async {
    _searching.sink.add(true);
    num s = DateTime.now().millisecondsSinceEpoch;
    print("Searching for query: $query");
    ContentWrapper res = await repo.contentQuerySearch(query, type);
    switch (res.statusCode) {
      case 200:
        {
          // Since there contentID.length requests to send, we want to send them simultaneously to avoid long wait time.
          List<MediaContent> contentLise = await Future.wait(res.contentID
              .map((itemId) => repo.contentIdSearch(itemId, type)));

          for (MediaContent content in contentLise) {
            // Some content items may be broken when fetching extended information.
            // Therefor they need to be skipped.
            if (content.id == 0) continue;
            _searchSubject.sink.add(content);
          }
          _searching.sink.add(false);
          print(
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
