import 'package:ombiapp/services/network/repository.dart';
import 'package:ombiapp/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class ConnectionTestBloc {
  final _connectionTestSubject = PublishSubject<bool>();

  Stream<bool> get connectionStream => _connectionTestSubject.stream;

  connect(String address) async {
    bool res = await repo.testConnection(address);
    logger.d("Server status response is $res");
    _connectionTestSubject.sink.add(res);
  }

  void dispose() {
    _connectionTestSubject.close();
  }
}
