import 'package:ombiapp/model/request/content/requests/episode.dart';

class SeasonRequest {
  final num _id;
  final List<EpisodeRequest> _episodes;

  SeasonRequest(this._id, this._episodes);

  Map<String, dynamic> toJson() => {'seasonNumber': _id, 'episodes': _episodes};
}
