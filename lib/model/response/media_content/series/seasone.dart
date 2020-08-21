import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/model/response/media_content/series/episode.dart';

/// Represents
class Season {
  num _number;
  List<Episode> _episodes;
  MediaContentStatus _status;

  Season.fromJson(Map<String, dynamic> json) {
    _number = json['seasonNumber'];
    _episodes = List();
    json['episodes'].forEach((e) => _episodes.add(Episode.fromJson(e)));

    validateSeasonStatus();
  }

  void validateSeasonStatus() {
    List<Episode> t = _episodes
        .where((element) => element.status != MediaContentStatus.AVAILABLE)
        .toList();
    if (t.isEmpty)
      _status = MediaContentStatus.AVAILABLE;
    else if (t.length != _episodes.length)
      _status = MediaContentStatus.PARTLY_AVAILABLE;
    else if (t.any((element) =>
        element.status == MediaContentStatus.REQUESTED ||
        element.status == MediaContentStatus.APPROVED))
      _status = MediaContentStatus.PROCESSING;
    else
      _status = MediaContentStatus.MISSING;
  }

  MediaContentStatus get status => _status;

  List<Episode> get episodes => _episodes;

  num get number => _number;
}
