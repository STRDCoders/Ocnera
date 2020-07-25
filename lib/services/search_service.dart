import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:ombiapp/services/network/content/query_search_bloc.dart';

class SearchManager {

  QuerySearchBloc _bloc = QuerySearchBloc();

  Stream<ContentWrapper> get querySearchStream => _bloc.searchStream;


  ContentWrapper searchQuery(String query , MediaContentType type){
    _bloc.search(query, type);

  }

  void dispose() {}
}
