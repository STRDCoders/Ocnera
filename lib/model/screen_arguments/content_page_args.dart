import 'package:ombiapp/contracts/media_content.dart';

/// Arguments required for the Movie content page.
class MovieContentArguments {
  /// Unique key required for the "Hero" widget in the Movie page.
  final num _index;
  final MediaContent _content;
  MovieContentArguments(this._index, this._content);


  MediaContent get content => _content;

  num get id => _index;
}
