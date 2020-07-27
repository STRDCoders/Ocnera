import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/services/search_service.dart';
import 'package:ombiapp/widgets/popup_item.dart';

class TopBar extends StatefulWidget {
  TopBar();

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  GlobalKey btnKey = GlobalKey();
  MediaContentType _contentSearchType = MediaContentType.MOVIE;

  // Used to avoid requests spam while typing in search bar.
  Timer timer;
  TextEditingController _editingController = TextEditingController();
  StreamSubscription _searchingStreamSubscribe;
  //Save last search query to see if anything changed on event.
  String _lastSearchQuery = "";
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Color.fromARGB(240, 31, 31, 31),
      floating: true,
      titleSpacing: 0,
      snap: true,
      title: Row(
        children: <Widget>[
          PopupMenuButton<MediaContentType>(
              icon: Icon(_contentSearchType.icon),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<MediaContentType>>[
                  PopupMenuItem<MediaContentType>(
                    value: MediaContentType.MOVIE,
                    child: PopupItem(
                        icon: Icon(MediaContentType.MOVIE.icon),
                        text: "Movies"),
                  ),
                  PopupMenuItem<MediaContentType>(
                      value: MediaContentType.SERIES,
                      child: PopupItem(
                          icon: Icon(MediaContentType.SERIES.icon),
                          text: "Series"))
                ];
              },
              onSelected: (res) {
                setState(() {
                  if (_contentSearchType != res) {
                    _contentSearchType = res;
                    _search(categoryChange: true);
                  }
                });
              }),
          Expanded(
              child: TextField(
                enabled: ! _isSearching,
            controller: _editingController,
            cursorColor: Colors.orange,
            decoration: InputDecoration(
              hintText: "Search..",
              //TODO - The values should be of enum "ContentType" instead of string.
            ),
            style: TextStyle(color: Colors.white),
          )),
          (_isSearching) ? Container(
            padding: EdgeInsets.all(20),
            child: SpinKitCircle(
              size: 15,
              color: Colors.white,
            ),) : Container()
        ],
      ),
      actions: <Widget>[],
      centerTitle: true,
    );
  }

  void _search({bool categoryChange = false}) {
    if (_editingController.text.trim().isNotEmpty &&
        (_lastSearchQuery != _editingController.text.trim() ||
            categoryChange)) {
      contentSearchManager.searchQuery(
          _editingController.text, _contentSearchType);
      _lastSearchQuery = _editingController.text.trim();
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    _searchingStreamSubscribe.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _editingController.addListener(() {
      if (_editingController.text.isNotEmpty) {
        if (timer != null) {
          timer.cancel();
          timer = null;
        }
        timer = Timer(Duration(milliseconds: 500), _search);
      }
    });
    _searchingStreamSubscribe = contentSearchManager.isSearching.listen((event) { setState(() {
      _isSearching = event;
    });});
    super.initState();
  }
}
