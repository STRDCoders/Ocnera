import 'package:ocnera/contracts/media_content_status.dart';

class Episode {
  num _number;
  String _title, _date;
  MediaContentStatus _status;

  MediaContentStatus get status => _status;

  get date => _date;

  String get title => _title;

  num get number => _number;

  Episode.fromJson(Map<String, dynamic> json) {
    this._number = json['episodeNumber'];
    this._title = json['title'];
    this._date = json['airDate'];
    if (json['available'])
      _status = MediaContentStatus.AVAILABLE;
    else if (json['approved'])
      _status = MediaContentStatus.APPROVED;
    else if (json['requested'])
      _status = MediaContentStatus.REQUESTED;
    else
      _status = MediaContentStatus.MISSING;
  }

  @override
  String toString() {
    return 'Episode{_number: $_number, _title: $_title, _date: $_date, _status: $_status}';
  }
}
