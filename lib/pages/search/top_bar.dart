import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/pages/search/content_type_popup.dart';
import 'package:ocnera/services/local_settings.dart';
import 'package:ocnera/services/search_service.dart';

class TopBar extends StatefulWidget {
  final Stream<void> scanTrigger;

  const TopBar({Key key, @required this.scanTrigger}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  MediaContentType _contentSearchType = localSettings.contentType;

  // Used to avoid requests spam while typing in search bar.
  Timer timer;
  TextEditingController _editingController = TextEditingController();
  List<StreamSubscription> _subscriptions = List();

  //Save last search query to see if anything changed on event.
  String _lastSearchQuery = "";
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Color.fromARGB(255, 31, 31, 31),
      floating: true,
      titleSpacing: 0,
      snap: true,
      title: Row(
        children: <Widget>[
          ContentTypePopUp(
            defaultType: _contentSearchType,
            onSelected: (res) {
              setState(() {
                if (_contentSearchType != res) {
                  _contentSearchType = res;
                  _search(categoryChange: true);
                }
              });
            },
          ),
          Expanded(
              child: TextField(
            enabled: !_isSearching,
            controller: _editingController,
            cursorColor: Colors.orange,
            decoration: InputDecoration(
              hintText: 'SEARCH_TOP_BAR'.tr(),
              //TODO - The values should be of enum "ContentType" instead of string.
            ),
            style: TextStyle(color: Colors.white),
          )),
//          (_isSearching) ? Container(
//            padding: EdgeInsets.all(20),
//            child: SpinKitCircle(
//              size: 15,
//              color: Colors.white,
//            ),) : Container()
        ],
      ),
      actions: <Widget>[],
      centerTitle: true,
    );
  }

  /// Send search request only if changes have been detected.
  ///
  /// In case the [categoryChange] is true, it means the category of the content has been changed
  /// therefor it needs to be requested with the new [_contentSearchType].
  ///
  /// In case the [rescan] is true, it means a refresh has been requested,
  /// therefor a new search with the current state is required.
  void _search({bool categoryChange: false, bool rescan: false}) {
    if (_editingController.text.trim().isEmpty && (categoryChange || rescan)) {
      defaultSearch();
      _lastSearchQuery = "";
    } else if (rescan ||
        (_editingController.text.trim().isNotEmpty &&
            (_lastSearchQuery != _editingController.text.trim() ||
                categoryChange))) {
      contentSearchManager.search(
          query: _editingController.text, type: _contentSearchType);
      _lastSearchQuery = _editingController.text.trim();
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    _subscriptions.forEach((element) => element.cancel);
    super.dispose();
  }

  @override
  void initState() {
    // Default search on page load
    contentSearchManager.search(type: _contentSearchType, defaultContent: true);
    _editingController.addListener(() {
      if (_editingController.text.isNotEmpty) {
        if (timer != null) {
          timer.cancel();
          timer = null;
        }
        timer = Timer(
            Duration(milliseconds: localSettings.searchDelay * 1000), _search);
      }
    });
    _subscriptions.add(contentSearchManager.isSearching.listen((event) {
      setState(() {
        _isSearching = event;
      });
    }));
    _subscriptions.add(widget.scanTrigger.listen((e) {
      _search(rescan: true);
    }));
    super.initState();
  }

  void defaultSearch() {
    contentSearchManager.search(type: _contentSearchType, defaultContent: true);
  }
}
