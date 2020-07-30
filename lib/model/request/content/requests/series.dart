import 'package:flutter/foundation.dart';
import 'package:ombiapp/contracts/media_content_request.dart';
import 'package:ombiapp/model/response/media_content/series/seasone.dart';

class SeriesContentRequestPodo extends MediaContentRequest {
  final bool requestAll, lastSeason, firstSeason;
  List<Season> seasons;

  SeriesContentRequestPodo(
      {@required num id,
      this.requestAll = false,
      this.lastSeason = false,
      this.firstSeason = false,
      this.seasons}): super(id);

  @override
  Map<String, dynamic> toJson() => {
        'requestAll': requestAll,
        'latestSeason': lastSeason,
        'firstSeason': firstSeason,
        'id': id,
        'seasons': seasons
      };
}
