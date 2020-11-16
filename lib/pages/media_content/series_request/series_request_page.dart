import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ocnera/contracts/media_content_status.dart';
import 'package:ocnera/model/request/content/requests/episode_request.dart';
import 'package:ocnera/model/request/content/requests/season_request.dart';
import 'package:ocnera/model/request/content/requests/series_request.dart';
import 'package:ocnera/model/response/media_content/series/series.dart';
import 'package:ocnera/model/screen_arguments/series_requests_episode.dart';
import 'package:ocnera/pages/media_content/series_request/season_panel.dart';
import 'package:ocnera/pages/media_content/series_request/season_panel_tile.dart';
import 'package:ocnera/services/request_service.dart';
import 'package:ocnera/utils/logger.dart';
import 'package:ocnera/utils/theme.dart';
import 'package:rxdart/rxdart.dart';

class SeriesRequestPage extends StatefulWidget {
  final SeriesContent seriesContent;

  const SeriesRequestPage({Key key, this.seriesContent}) : super(key: key);

  @override
  _SeriesRequestSelectionState createState() => _SeriesRequestSelectionState();
}

class _SeriesRequestSelectionState extends State<SeriesRequestPage> {
  List<SeasonExpansionPanel> items = List();

  // All current requests of the user will be stored here, items of this list will be sent upon submit to server.
  Map<num, List<num>> episodeRequests = Map();
  PublishSubject<EpisodeRequestAction> _requests;

  List<StreamSubscription> _streamSubscription = List();
  bool inProcess = false;

  @override
  void initState() {
    super.initState();
    _requests = PublishSubject();

    //Build ExpansionPanels.
    widget.seriesContent.seasons.forEach((season) {
      episodeRequests[season.number] = List();
      items.add(SeasonExpansionPanel(
          season: season,
          requestList: episodeRequests[season.number],
          notifyRequest: _requests));
    });

    _streamSubscription.add(_requests.stream.listen(addRequestItem));
    _streamSubscription.add(requestManager.requestStream.listen(postSubmit));
  }

  @override
  void dispose() {
    super.dispose();
    appLogger.log(LoggerTypes.DEBUG, 'Disposing series requests');
    _streamSubscription.forEach((sub) => sub.cancel());
    _requests.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.APP_BACKGROUND.withOpacity(1),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 125,
            bottom:
                PreferredSize(preferredSize: Size(10.0, 10.0), child: Text('')),
            leading: Container(),
            backgroundColor: AppTheme.APP_BACKGROUND,
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        widget.seriesContent.title,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 30,
                            child: FlatButton(
                              child: Text(
                                'SELECT_ALL'.tr(),
                                style: TextStyle(fontSize: 10),
                              ),
                              onPressed: requestAll,
                            ),
                          ),
                          Container(
                              width: 90,
                              height: 30,
                              child: this.inProcess
                                  ? SpinKitCircle(
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  : FlatButton(
                                      child: Text(
                                        'SUBMIT'.tr(),
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      onPressed: submitRequest,
                                    ))
                        ],
                      ),
                    )
                  ],
                )),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      bool newState = !items[index].expended;
                      items.forEach((element) {
                        element.expended = false;
                      });
                      items[index].expended = newState;
                    });
                  },
                  children: items.map((SeasonExpansionPanel item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return SeasonExpansionTile(
                          item: item,
                          episodeRequests: episodeRequests[item.season.number],
                        );
                      },
                      isExpanded: item.expended,
                      body: item.body,
                      canTapOnHeader: true,
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void requestAll() {
    setState(() {
      widget.seriesContent.seasons.forEach((season) {
        // Skip available seasons.
        if (season.status == MediaContentStatus.AVAILABLE) return;
        season.episodes
            .where((element) => element.status == MediaContentStatus.MISSING)
            .forEach((episode) {
          // Deny duplicates.
          if (!episodeRequests[season.number].contains(episode.number))
            episodeRequests[season.number].add(episode.number);
        });
      });
    });
  }

  /// Handle new episode request, add/remove from request list & update state.
  void addRequestItem(EpisodeRequestAction event) {
    if (!event.remove &&
        (!episodeRequests[event.seasonId].contains(event.episodeId)))
      episodeRequests[event.seasonId].add(event.episodeId);
    else
      episodeRequests[event.seasonId].remove(event.episodeId);
    setState(() {});
  }

  void submitRequest() {
    bool isEmptyRequest = true;
    episodeRequests.entries.any((element) {
      if (element.value.isNotEmpty) {
        isEmptyRequest = false;
        return true;
      }
      return false;
    });
    if (isEmptyRequest) {
      return;
    }
    setState(() {
      inProcess = true;
    });
    List<SeasonRequest> sRequest = List();
    episodeRequests.forEach((key, value) {
      sRequest.add(
          SeasonRequest(key, value.map((e) => EpisodeRequest(e)).toList()));
    });
    SeriesContentRequest request =
        SeriesContentRequest(id: widget.seriesContent.id, seasons: sRequest);
    requestManager.requestContent(widget.seriesContent, request);
  }

  void postSubmit(event) {
    setState(() {
      inProcess = false;
    });
    Navigator.pop(context);
  }
}
