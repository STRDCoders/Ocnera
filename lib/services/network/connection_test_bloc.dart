import 'package:rxdart/rxdart.dart';

class ConnectionTestBloc {
  final _connectionTestSubject = PublishSubject<bool>();
  Stream <bool> get connectionStream => _connectionTestSubject.stream;

  connect() async {

  }

  void dispose() {
    _connectionTestSubject.close();
  }

}