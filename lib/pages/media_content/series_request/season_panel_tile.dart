import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/contracts/media_content_status.dart';
import 'package:ocnera/model/screen_arguments/series_requests_episode.dart';
import 'package:ocnera/pages/media_content/series_request/season_panel.dart';

class SeasonExpansionTile extends StatefulWidget {
  final SeasonExpansionPanel item;
  final List<num> episodeRequests;

  const SeasonExpansionTile({Key key, @required this.item, @required this.episodeRequests})
      : super(key: key);

  @override
  _SeasonExpansionTileState createState() => _SeasonExpansionTileState();
}

class _SeasonExpansionTileState extends State<SeasonExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: widget.item.header,
        subtitle: (widget.episodeRequests.isNotEmpty)
            ? Text(
                '${widget.episodeRequests.length} ${'EPISODES_SELECTED'.tr()}')
            : null,
        trailing: _buildButton());
  }

  Widget _buildButton() {
    if (widget.item.season.status == MediaContentStatus.AVAILABLE ||
        (widget.item.season.status == MediaContentStatus.PROCESSING &&
            widget.item.missingEpisodes.isEmpty))
      return Text(
        widget.item.season.status.title,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.green),
      );
    return (widget.episodeRequests.isNotEmpty)
        ? RaisedButton(
      child: Text('CANCEL'.tr()),
      color: Colors.cyan,
      onPressed: () {
        widget.item.season.episodes.forEach((element) {
          widget.item.notifyRequest.sink.add(EpisodeRequestAction(
              episodeId: element.number,
              seasonId: widget.item.season.number,
              remove: true));
        });
      },
    )
        : RaisedButton(
      child: Text(widget.item.season.status.title),
      onPressed: () {
        widget.item.missingEpisodes.forEach((element) {
          widget.item.notifyRequest.sink.add(EpisodeRequestAction(
              episodeId: element,
              seasonId: widget.item.season.number,
              remove: false));
        });
      },
    );
  }
}
