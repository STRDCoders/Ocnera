import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/model/response/media_content/content_wrapper.dart';
import 'package:ombiapp/pages/search/content_card.dart';
import 'package:ombiapp/services/search_service.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

import 'top_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchManager _manager;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: UtilsImpl.getScreenWidth(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(-.2, 0),
                //TODO - Change this static image.
                image: CachedNetworkImageProvider(
                  "https://assets.fanart.tv/fanart/tv/280619/showbackground/the-expanse-56b63fb90c028.jpg",
                ),
                fit: BoxFit.cover),
          ),
          alignment: Alignment.bottomLeft,
        ),
        CustomScrollView(
          slivers: <Widget>[
            TopBar(_manager),
            StreamBuilder<ContentWrapper>(
                stream: _manager.querySearchStream,
                builder: (context, snapshot) => SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => ContentCard(
                          index: index, content: snapshot.data.content[index]),
                      childCount:
                          snapshot.hasData ? snapshot.data.content.length : 0,
                    )))
          ],
        )
      ],
    ); //    return Column(
  }

  @override
  void initState() {
    _manager = SearchManager();
    super.initState();
  }
}
