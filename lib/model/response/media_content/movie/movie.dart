import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ocnera/contracts/media_content.dart';
import 'package:ocnera/contracts/media_content_status.dart';
import 'package:ocnera/contracts/media_content_type.dart';
import 'package:ocnera/widgets/rating.dart';

class MovieContent extends MediaContent {
  bool _adult;
  String _language;
  String _plexUrl;
  String _embyUrl;

  bool get adult => _adult;

  get plexUrl => _plexUrl;

  get language => _language;

  get embyUrl => _embyUrl;

  MovieContent.fromJson(Map<String, dynamic> json) {
    var contentStatus;
    // Check plexUrl as well as the reported status, since sometimes the content
    // may no longer be available but the status is still set as 'available'
    if (json['available']) {
      if (json['plexUrl'] != null || json['embyUrl'] != null)
        contentStatus = MediaContentStatus.AVAILABLE;
      else
        contentStatus = MediaContentStatus.REMOVED;
    } else if (json['requested'])
      contentStatus = MediaContentStatus.REQUESTED;
    else
      contentStatus = MediaContentStatus.MISSING;

    this.setData(
        contentType: MediaContentType.MOVIE,
        title: json['originalTitle'],
        banner: MediaContentType.MOVIE.optimizedBanner(json['posterPath']),
        background: (json['backdropPath'] != null)
            ? "${GlobalConfiguration().get('API_LINK_CONTENT_MOVIE_POSTER')}/${json['backdropPath']}"
            : this.banner,
        overview: json['overview'],
        releaseDate: MediaContentType.MOVIE.dateTime(json['releaseDate']),
        id: json['id'],
        contentStatus: contentStatus,
        voteRating: json['voteAverage'] == null ? 0 : json['voteAverage'],
        voteCount: json['voteCount']);

    this._adult = json['adult'];
    this._language = json['originalLanguage'];
    this._plexUrl = json['plexUrl'];
    this._embyUrl = json['embyUrl'];
  }

  @override
  Widget cardTopRight() {
    return ContentRating(rating: Text(this.voteRating.toStringAsFixed(1)));
  }

  @override
  Widget cardLeftBottom() {
    return Row(
      children: <Widget>[
        Text(this._language.toUpperCase()),
//        (_adult) ? Container(color: Colors.red,child: Text("18+"),) : Container()
      ],
    );
  }

  @override
  Widget contentPageTitle() {
    return cardTopRight();
  }
}
