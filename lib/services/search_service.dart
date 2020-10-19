import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ocnera/contracts/media_content.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/services/network/content/query_search_bloc.dart';

class SearchManager {
  QuerySearchBloc _bloc = QuerySearchBloc();
  StreamSubscription _subscription;

  //This is here to allow access to currently on screen items from different widgets.
//  List<MediaContent> _searchItems = List();
  Map<num, MediaContent> _searchItems = Map();

  SearchManager() {
    _subscription = _bloc.searchStream.listen((event) {
      _searchItems[event.id] = event;
    });
  }

  Stream<MediaContent> get querySearchStream => _bloc.searchStream;

  Stream<bool> get isSearching => _bloc.isSearching;

  Map<num, MediaContent> get searchItems => _searchItems;

  void search(
      {String query,
      bool,
      defaultContent = false,
      @required MediaContentType type}) {
    _searchItems = Map();
    _bloc.search(query: query, defaultContent: defaultContent, type: type);
  }

  void dispose() {
    _subscription.cancel();
  }
}

SearchManager contentSearchManager = SearchManager();
