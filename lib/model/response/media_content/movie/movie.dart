import 'package:flutter/cupertino.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/widgets/rating.dart';

class MovieContent extends MediaContent {
  bool _adult;
  String _language;

  bool get adult => _adult;


  get language => _language;

  MovieContent.fromJson(Map<String, dynamic> json) {
  var contentStatus;
    if (json['available'])
      contentStatus = MediaContentStatus.AVAILABLE;
    else if (json['requested'])
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
    voteRating:  json['voteAverage'] == null ? 0 : json['voteAverage'],
    voteCount: json['voteCount']);
//    this.title = json['originalTitle'];
//    this.banner = MediaContentType.MOVIE.optimizedBanner(json['posterPath']);
//    this.releaseDate = MediaContentType.MOVIE.dateTime(json['releaseDate']);
//            this.id = json['id'];
//    this.overview = json['overview'];
    //    this.background = (json['backdropPath'] != null)
//        ? "${GlobalConfiguration().get('API_LINK_CONTENT_MOVIE_POSTER')}/${json['backdropPath']}"
//        : this.banner;

//
//    this.voteRating = json['voteAverage'] == null ? 0 : json['voteAverage'];
//    this.voteCount = json['voteCount'];
    this._adult = json['adult'];
    this._language = json['originalLanguage'];
  }

  @override
  Widget cardTopRight() {
    return ContentRating(rating: Text(this.voteRating.toStringAsFixed(1)));
  }

  @override
  Widget cardLeftBottom() {
    return Text(this._language.toUpperCase());
  }

  @override
  Widget contentPageTitle() {
    return cardTopRight();
  }
}
