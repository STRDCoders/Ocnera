import 'package:ombiapp/model/response/content/series/episode.dart';
/// Represents
class Season{
  num _number;
  List<Episode> _episodes;

  Season.fromJson(Map<String,dynamic> json) {
    _number = json['seasonNumber'];
    _episodes = json['episodes'];
  }

  List<Episode> get episodes => _episodes;

  num get number => _number;


}