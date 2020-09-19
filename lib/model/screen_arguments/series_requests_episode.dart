import 'package:flutter/cupertino.dart';
import 'package:ombiapp/model/response/media_content/series/episode.dart';

/// Representing a single episode request.
///
/// [EpisodeRequestAction] is being transmitted in a stream while marking episodes/seasons for a request.
/// The stream is between seasons panel and the main request card of the season.
class EpisodeRequestAction {
  final num seasonId, episodeId;
  // What action to do with the episode, remove from request on true, add otherwise.
  final bool remove;

  EpisodeRequestAction(
      {@required this.seasonId,
      @required this.episodeId,
      @required this.remove});
}
