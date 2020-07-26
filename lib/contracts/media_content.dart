import 'package:flutter/cupertino.dart';
import 'package:ombiapp/contracts/media_content_status.dart';

abstract class MediaContent {
  String title, banner, background, overview;
  DateTime releaseDate;
  num voteRating = 0, voteCount = 0;
  num id;
  MediaContentStatus contentStatus;

  /// Initialize the shared media data. It is required for each mediaContent!
  setData(
      {@required title,
      @required banner,
      @required background,
      @required overview,
      @required releaseDate,
      voteRating,
      voteCount,
      @required id,
      @required contentStatus}) {}

//TODO - Create functions to return different data for different locations in the app(Ex. Top right corner of a card)

}
