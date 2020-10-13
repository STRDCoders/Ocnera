class UnsupportedException implements Exception {
  String _message;

  UnsupportedException([String message = 'Unsupported Section']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
