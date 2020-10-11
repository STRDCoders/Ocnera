import 'package:flutter/foundation.dart';
import 'package:ombiapp/contracts/media_content_request.dart';
import 'package:ombiapp/model/request/content/requests/season.dart';

class SeriesContentRequestPodo extends MediaContentRequest {
  final bool requestAll, lastSeason, firstSeason;
  List<SeasonRequest> seasons;

  SeriesContentRequestPodo(
      {@required num id,
      this.requestAll = false,
      this.lastSeason = false,
      this.firstSeason = false,
      this.seasons})
      : super(id);

  @override
  Map<String, dynamic> toJson() => {
        'requestAll': requestAll,
        'latestSeason': lastSeason,
        'firstSeason': firstSeason,
        'tvDbId': id,
        'seasons': seasons
      };

  @override
  String toString() {
    return 'SeriesContentRequestPodo{id: ${id}, requestAll: $requestAll, lastSeason: $lastSeason, firstSeason: $firstSeason, seasons: $seasons}';
  }
}
