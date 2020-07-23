class Episode {
  num _number;
  String _title, _date;
  bool _available, _requested, _approved;

  get approved => _approved;

  get requested => _requested;

  bool get available => _available;

  get date => _date;

  String get title => _title;

  num get number => _number;

  Episode.fromJson(Map<String,dynamic> json) {
    this._number = json['episodeNumber'];
    this._title = json['title'];
    this._date = json['airDate'];
    this._available = json['available'];
    this._requested = json['requested'];
    this._approved = json['approved'];
  }
}
