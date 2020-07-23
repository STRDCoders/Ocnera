import 'package:ombiapp/contracts/content.dart';
import 'package:ombiapp/contracts/network_response.dart';

class Movie extends Content{
  bool _adult, _available;
  String _background,  _language;
  double _voteRating, _voteCount;
  num _theMovieDbId;


  bool get adult => _adult;

  get available => _available;

  String get background => _background;

  get language => _language;

  double get voteRating => _voteRating;

  get voteCount => _voteCount;

  num get theMovieDbId => _theMovieDbId;



  Movie.fromJson(Map<String, dynamic> json, num statusCode)
      : super(statusCode) {
    this.title = json['originalTitle'];
    this.banner = json['posterPath'];
    this.releaseDate = DateTime.parse(json['releaseDate']);
    this.overview = json['overview'];

    this._adult = json['adult'];
    this._background = json['backdropPath'];
    this._language = json['originalLanguage'];
    this._voteRating = json['voteAverage'];
    this._voteCount = json['voteCount'];
    this._theMovieDbId = json['theMovieDbId'];
    this._available = json['available'];
  }

  Movie(num statusCode) : super(statusCode);

}
