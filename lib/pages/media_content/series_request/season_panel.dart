import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/model/response/media_content/series/episode.dart';
import 'package:ombiapp/model/response/media_content/series/seasone.dart';
import 'package:ombiapp/model/screen_arguments/series_requests_episode.dart';
import 'package:ombiapp/utils/utilsImpl.dart';
import 'package:rxdart/rxdart.dart';

class SeasonExpansionPanel {
  bool expended;
  final Season season;

  // Saves the current status of each requested episode.
  final List<num> requestList;

  /// Contains a list of episode id's with [MediaContentStatus.MISSING] status.
  List<num> missingEpisodes = List();
  final PublishSubject<EpisodeRequestAction> notifyRequest;

  SeasonExpansionPanel(
      {this.expended = false,
      @required this.season,
      @required this.requestList,
      @required this.notifyRequest}) {
    season.episodes.forEach((element) {
      if (element.status == MediaContentStatus.MISSING)
        missingEpisodes.add(element.number);
    });
  }

  Widget get header => Text("Season ${season.number}");

  Widget get body => _buildBody();

  Widget _buildBody() {
    return SeasonExpansionPanelUI(
      season: season,
      requestList: requestList,
      notifyRequest: notifyRequest,
    );
  }
}

class SeasonExpansionPanelUI extends StatefulWidget {
  final Season season;
  final List<num> requestList;
  final PublishSubject<EpisodeRequestAction> notifyRequest;

  const SeasonExpansionPanelUI(
      {Key key,
      @required this.season,
      @required this.requestList,
      @required this.notifyRequest})
      : super(key: key);

  @override
  _SeasonExpansionPanelUIState createState() => _SeasonExpansionPanelUIState();
}

class _SeasonExpansionPanelUIState extends State<SeasonExpansionPanelUI> {
  List<Episode> episodes;

  @override
  void initState() {
    super.initState();
    episodes = widget.season.episodes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: UtilsImpl.getScreenHeight(context, true) * 0.6,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              bool requested =
                  widget.requestList.contains(episodes[index].number);
              return ListTile(
                title: Text(episodes[index].title),
                leading: Text(
                  episodes[index].number.toString(),
                ),
                trailing: (episodes[index].status != MediaContentStatus.MISSING)
                    ? null
                    : IconButton(
                        icon:
                            (requested) ? Icon(Icons.remove) : Icon(Icons.add),
                        onPressed: () {
                          if (requested) {
                            widget.notifyRequest.sink.add(EpisodeRequestAction(
                                remove: true,
                                seasonId: widget.season.number,
                                episodeId: episodes[index].number));
                            return;
                          }
                          widget.notifyRequest.sink.add(EpisodeRequestAction(
                              remove: false,
                              seasonId: widget.season.number,
                              episodeId: episodes[index].number));
                        },
                      ),
                subtitle: Text(episodes[index].status.title),
              );
            },
            itemCount: widget.season.episodes.length,
          ),
        ));
  }
}
