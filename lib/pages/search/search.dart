import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ocnera/pages/search/content_card.dart';
import 'package:ocnera/services/animation/particle_painter.dart';
import 'package:ocnera/services/request_service.dart';
import 'package:ocnera/services/search_service.dart';
import 'package:ocnera/utils/theme.dart';
import 'package:ocnera/utils/utilsImpl.dart';
import 'package:rxdart/rxdart.dart';

import 'top_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<StreamSubscription> _subscription = List();
  PublishSubject<void> _rescanSubject = PublishSubject();
  final ScrollController _scrollController = ScrollController();
  TopBar _topBar;

  @override
  Widget build(BuildContext context) {
    //Required for building the cards.
    double screenRatio = UtilsImpl.getScreenRatio(context);
    return Stack(
      children: <Widget>[
        Positioned.fill(child: AnimatedBackground()),
        Positioned.fill(child: Particles(3)),
        RefreshIndicator(
            onRefresh: rescan,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                _topBar,
                StreamBuilder(
                    stream: contentSearchManager.isSearching,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      // ConnectionState will be "waiting" when initializing the page.
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasData && snapshot.data)
                        return SliverToBoxAdapter(
                            child: Container(
                                height:
                                    UtilsImpl.getScreenHeight(context, true),
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
                                      'NO_RESULTS'.tr(),
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              )));
                    }),
              ],
            ))
      ],
    );
  }

  @override
  void initState() {
    _topBar = TopBar(scanTrigger: _rescanSubject.stream);
    _subscription.add(requestManager.requestStream.listen((data) {
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
          .showSnackBar(SnackBar(
              content: Text(data.message != null
                  ? data.message
                  : "Content has been requested!"))));
    }));
    _subscription.add(contentSearchManager.isSearching.listen(_resetScroll));
    super.initState();
  }

  @override
  void dispose() {
    for (var sub in _subscription) sub.cancel();
    _rescanSubject.close();
    super.dispose();
  }

  void _resetScroll(bool isSearching) {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> rescan() async {
    _rescanSubject.add(null);
  }
}
