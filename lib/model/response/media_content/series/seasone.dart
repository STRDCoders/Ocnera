import 'package:ombiapp/model/response/media_content/series/episode.dart';
/// Represents
class Season{
  num _number;
  List<Episode> _episodes;

  Season.fromJson(Map<String,dynamic> json) {
    _number = json['seasonNumber'];
    _episodes = List();
    if(json['episodes']){
      json['episodes'].forEach((e) => _episodes.add(Episode.fromJson(e)));
    }
  }

  List<Episode> get episodes => _episodes;

  num get number => _number;


}