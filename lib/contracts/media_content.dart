import 'package:ombiapp/contracts/media_content_status.dart';

abstract class MediaContent  {
  String title, banner, background, overview;
  DateTime releaseDate;
  num voteRating=0, voteCount=0;
  num id;
  MediaContentStatus contentStatus;
}