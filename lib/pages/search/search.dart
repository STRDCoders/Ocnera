import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombiapp/contracts/media_content.dart';
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
  List<StreamSubscription> _subscription = List();

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
                  "https://image.tmdb.org/t/p/w500//pU1ULUq8D3iRxl1fdX2lZIzdHuI.jpg",
                ),
                fit: BoxFit.cover),
          ),
          alignment: Alignment.bottomLeft,
        ),
        CustomScrollView(
          slivers: <Widget>[
            TopBar(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => ContentCard(
                  index: index,
                  content: contentSearchManager.searchItems[index]),
              childCount: contentSearchManager.searchItems.length,
            ))
          ],
        )
      ],
    ); //    return Column(
  }

  @override
  void initState() {
    //We want to update the UI when the search query has finished its requests OR new content has been loaded.
    _subscription.add(contentSearchManager.isSearching.listen((event) {
      if (!event) setState(() {});
    }));
    _subscription.add(contentSearchManager.querySearchStream.listen((event) {
      setState(() {});
    }));
    super.initState();
  }

  @override
  void dispose() {
    for(var sub in _subscription)
      sub.cancel();

    super.dispose();
  }
}
