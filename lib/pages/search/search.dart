import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/pages/search/content_card.dart';
import 'package:ombiapp/services/animation/particle_painter.dart';
import 'package:ombiapp/services/request_service.dart';
import 'package:ombiapp/services/search_service.dart';
import 'package:ombiapp/utils/theme.dart';
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
    //Required for building the cards.
    double screenRatio = UtilsImpl.getScreenRatio(context);
    return Stack(
      children: <Widget>[
        Positioned.fill(child: AnimatedBackground()),
        Positioned.fill(child: Particles(3)),
        CustomScrollView(
          slivers: <Widget>[
            TopBar(),
            StreamBuilder(
                stream: contentSearchManager.isSearching,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  // ConnectionState will be "waiting" when initializing the page.
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasData && snapshot.data)
                    return SliverToBoxAdapter(
                        child: Container(
                            height: UtilsImpl.getScreenHeight(context, true),
                            color: AppTheme.APP_BACKGROUND.withOpacity(0.4),
                            padding: EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SpinKitDualRing(
                                  size: 30,
                                  color: Colors.white,
                                  lineWidth: 3,
                                )
                              ],
                            )));
                  if (contentSearchManager.searchItems.isNotEmpty) {
                    var iter = contentSearchManager.searchItems.values;
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => ContentCard(
                          ratio: screenRatio,
                          index: index,
                          content: iter.elementAt(index)),
                      childCount: iter.length,
                    ));
                  }
                  return SliverToBoxAdapter(
                      child: Container(
                          height: UtilsImpl.getScreenHeight(context, true),
                          color: AppTheme.APP_BACKGROUND.withOpacity(0.4),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "No results",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          )));
                }),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    _subscription.add(requestManager.requestStream.listen((data) {
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
          .showSnackBar(SnackBar(
              content: Text(data.message != null
                  ? data.message
                  : "Content has been requested!"))));
    }));

    super.initState();
  }

  @override
  void dispose() {
    for (var sub in _subscription) sub.cancel();
    super.dispose();
  }
}
