import 'package:ombiapp/contracts/content.dart';
import 'package:ombiapp/model/response/content/series/seasone.dart';

class Series extends Content{
  /// Is show running
  String _status,
      _network, _runtime;
  List<Season> _seasons;


  List<Season> get seasons => _seasons;

  get runtime => _runtime;

  get network => _network;

  String get status => _status;

  //TODO - Check if another wrapper class "SeriesExtended" is required to fetch the second part of data(extended) or just leave it here(does the api request contains those values via search query).
  Series.fromJson(Map<String, dynamic> json, num statusCode):super(statusCode) {
    this.title = json['title'];
    this.overview = json['overview'];


    this._status = json['status'];
    this.releaseDate = DateTime.parse(json['firstAired']);
    this._network = json['network'];
    this._runtime = json['runTime'];
    this._seasons = json['seasonRequests'];
  }

  Series(num statusCode): super(statusCode);


}