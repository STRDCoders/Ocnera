import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/services/network/content/query_search_bloc.dart';

class SearchManager {
  QuerySearchBloc _bloc = QuerySearchBloc();
  StreamSubscription _subscription;

   //This is here to allow access to currently on screen items from different widgets.
  List<MediaContent> _searchItems = List();

  SearchManager() {
    _subscription = _bloc.searchStream.listen((event) {
      _searchItems.add(event);
    });
  }
  Stream<MediaContent> get querySearchStream => _bloc.searchStream;
  Stream<bool> get isSearching => _bloc.isSearching;
  List<MediaContent> get searchItems => _searchItems;

  void search({String query, bool, defaultContent = false, @required MediaContentType type}) {
    _searchItems = List();
    _bloc.search(query: query,defaultContent: defaultContent, type: type);
  }

//  void searchDefault(MediaContentType type) {
//    _searchItems = List();
//
//  }
  void dispose() {
    _subscription.cancel();
  }
}
SearchManager contentSearchManager = SearchManager();
