import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/services/search_service.dart';
import 'package:ombiapp/widgets/popup_item.dart';

class TopBar extends StatefulWidget {
  final SearchManager _manager;
  TopBar(this._manager);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  GlobalKey btnKey = GlobalKey();
  MediaContentType _contentSearchType = MediaContentType.MOVIE;
  // Used to avoid requests spam while typing in search bar.
  Timer timer;
  TextEditingController _editingController = TextEditingController();
  //Save last search query to see if anything changed on event.
  String _lastSearchQuery = "";

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
                    child: PopupItem(icon: Icon(MediaContentType.MOVIE.icon), text: "Movies"),
                  ),
                  PopupMenuItem<MediaContentType>(
                      value: MediaContentType.SERIES,
                      child: PopupItem(icon: Icon(MediaContentType.SERIES.icon), text: "Series"))
                ];
              },
              onSelected: (res) {
                setState(() {
                  if(_contentSearchType != res){
                    _contentSearchType = res;
                    _search(categoryChange: true);
                  }
                });
              }),
          Expanded(
              child: TextField(
            controller: _editingController,
            cursorColor: Colors.orange,
            decoration: InputDecoration(
              hintText: "Search..",
              //TODO - The values should be of enum "ContentType" instead of string.
            ),
            style: TextStyle(color: Colors.white),
          ))
        ],
      ),
      actions: <Widget>[],
      centerTitle: true,
    );
  }

  void _search({bool categoryChange = false}) {

    if(_editingController.text.trim().isNotEmpty && (_lastSearchQuery != _editingController.text.trim() || categoryChange )) {
      widget._manager.searchQuery(_editingController.text, _contentSearchType);
      _lastSearchQuery = _editingController.text.trim();
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
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
    super.initState();
  }
}
