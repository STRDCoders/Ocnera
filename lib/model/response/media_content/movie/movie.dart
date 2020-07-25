import 'package:global_configuration/global_configuration.dart';
import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/utils/content_utilizer.dart';

class MovieContent extends MediaContent {
  bool _adult, _available;
  String _language;

  bool get adult => _adult;

  get available => _available;

  get language => _language;

  MovieContent.fromJson(Map<String, dynamic> json) {
    this.title = json['originalTitle'];
    this.banner = MediaContentConverter.optimizeBanner(json['posterPath'], MediaContentType.MOVIE);
    this.releaseDate = MediaContentConverter.toDate(json['releaseDate'], MediaContentType.MOVIE);

    this.overview = json['overview'];
    this.voteRating = json['voteAverage'] == null ? 0 : json['voteAverage'];
    this.voteCount = json['voteCount'];
    if (json['available'])
      this.contentStatus = MediaContentStatus.AVAILABLE;
    else if (json['requested'])
      this.contentStatus = MediaContentStatus.REQUESTED;
    else this.contentStatus = MediaContentStatus.MISSING;
print("Status of content: ${this.contentStatus}");
    this._adult = json['adult'];
    this.background =
        "${GlobalConfiguration().get('API_LINK_CONTENT_MOVIE_POSTER')}/${json['backdropPath']}";
    this._language = json['originalLanguage'];
    this.id = json['id'];
    this._available = json['available'];
  }
}
