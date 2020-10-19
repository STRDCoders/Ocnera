import 'package:flutter/foundation.dart';
import 'package:ocnera/contracts/media_content_request.dart';
import 'package:ocnera/model/request/content/requests/season_request.dart';

class SeriesContentRequest extends MediaContentRequest {
  final bool requestAll, lastSeason, firstSeason;
  List<SeasonRequest> seasons;

  SeriesContentRequest(
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
    return 'SeriesContentRequest{id: $id, requestAll: $requestAll, lastSeason: $lastSeason, firstSeason: $firstSeason, seasons: $seasons}';
  }
}
