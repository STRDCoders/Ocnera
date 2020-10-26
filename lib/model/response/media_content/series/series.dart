import 'package:flutter/cupertino.dart';
import 'package:ocnera/contracts/media_content.dart';
import 'package:ocnera/contracts/media_content_status.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/model/response/media_content/series/seasone.dart';

class SeriesContent extends MediaContent {
  /// Is show running
  String _status, _network, _runtime;
  List<Season> _seasons;

  List<Season> get seasons => _seasons;

  get runtime => _runtime;

  get network => _network;

  String get status => _status;

  //TODO - Check if another wrapper class "SeriesExtended" is required to fetch the second part of data(extended) or just leave it here(does the api request contains those values via search query).
  SeriesContent.fromJson(Map<String, dynamic> json) {
    var contentStatus;
    if (json['fullyAvailable'])
      contentStatus = MediaContentStatus.AVAILABLE;
    else if (json['partlyAvailable'] || json['available'])
      contentStatus = MediaContentStatus.PARTLY_AVAILABLE;
    else
      contentStatus = MediaContentStatus.MISSING;

    this.setData(
        contentType: MediaContentType.SERIES,
        title: json['title'],
        banner: MediaContentType.SERIES.optimizedBanner(json['banner']),
        background: MediaContentType.SERIES.optimizedBanner(json['banner']),
        overview: json['overview'],
        releaseDate: MediaContentType.SERIES.dateTime(json['firstAired']),
        id: json['id'],
        contentStatus: contentStatus);
//    this.title = json['title'];
//    this.overview = json['overview'];
//    this.banner = MediaContentType.SERIES.optimizedBanner(json['banner']);
//    this.background = MediaContentType.SERIES.optimizedBanner(json['banner']);
//    this.id = json['id'];
//    this.releaseDate = MediaContentType.SERIES.dateTime(json['firstAired']);

    this._status = json['status'];
    this._network = json['network'];
    this._runtime = json['runTime'];
    this._seasons = List();
    json['seasonRequests'].forEach((s) => _seasons.add(Season.fromJson(s)));
  }

  @override
  Widget cardTopRight() {
    return (this.status != null) ? Text(this.status) : Container();
  }

  @override
  Widget cardLeftBottom() {
    return (this._network != null) ? Text(this._network) : Container();
  }

  @override
  Widget contentPageTitle() {
    return network != null ? Text(this.network) : Container();
  }
}
