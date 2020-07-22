/// Arguments required for the Movie content page.
class MovieContentArguments {
  /// Unique key required for the "Hero" widget in the Movie page.
  num _index;

  MovieContentArguments(this._index);

  num get id => _index;
}
