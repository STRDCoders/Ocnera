import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:rxdart/rxdart.dart';

/// Responsible for managing the fetch of extra information of contents
class ContentSearchBloc {

//  final _searchSubject = PublishSubject<ContentWrapper>();
//  Stream <ContentWrapper> get searchStream => _searchSubject.stream;
//
//  Future<void> search(String query, ContentType type) async{
//    ContentWrapper res = await repo.contentQuerySearch(query, type);
//    switch (res.statusCode){
//      case 200: {
//        _searchSubject.sink.add(res);
//        // TODO - sink success.
//      }
//      break;
//      case 401: {
//        _searchSubject.sink.addError(NetworkError(res.statusCode, "One of the credentials is incorrect!"));
//      }
//      break;
//      default: {
//        _searchSubject.sink.addError(NetworkError(res.statusCode, "An unknown error has occurred."));
//        //TODO - Sink error
//      }
//    }
//  }
//
//  dispose() {
//    print('disposing identify stream');
//    _searchSubject.close();
//  }

}

