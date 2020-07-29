import 'package:flutter/cupertino.dart';
import 'package:ombiapp/contracts/media_content_status.dart';
import 'package:ombiapp/contracts/media_content_type.dart';

abstract class MediaContent {
  String title, banner, background, overview;
  DateTime releaseDate;
  num voteRating ,
      voteCount ;
  num id;
  MediaContentStatus contentStatus;
  MediaContentType contentType;

  /// Initialize the shared media data. It is required for each mediaContent!
  setData({
    @required contentType,
    @required title,
    @required banner,
    @required background,
    @required overview,
    @required releaseDate,
    voteRating = 0 ,
    voteCount = 0,
    @required id,
    @required contentStatus}) {
    this.contentType = contentType;
    this.title = title;
    this.banner = banner;
    this.background = background;
    this.overview = overview;
    this.releaseDate = releaseDate;
    this.id = id;
    this.contentStatus = contentStatus;
    this.voteRating = voteRating;
    this.voteCount = voteCount;
  }

  // Each content type might show different information(Ex. rating is only used for movies, series has network name, etc.)
  Widget cardTopRight();

  Widget cardLeftBottom();

  Widget contentPageTitle();

}
