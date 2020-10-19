import 'package:ocnera/model/network_error.dart';
import 'package:ocnera/model/response/user.dart';
import 'package:ocnera/services/network/repository.dart';
import 'package:ocnera/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class IdentityBloc {
  final _identitySubject = PublishSubject<User>();

  Stream<User> get identityStream => _identitySubject.stream;

  identify() async {
    User res = await repo.getIdentity();
    logger.d("response for login: $res");
    switch (res.statusCode) {
      case 200:
        {
          _identitySubject.sink.add(res);
          // TODO - sink success.
        }
        break;
      case 401:
        {
          _identitySubject.sink.addError(NetworkError(
              res.statusCode, "One of the credentials is incorrect!"));
        }
        break;
      default:
        {
          _identitySubject.sink.addError(
              NetworkError(res.statusCode, "An unknown error has occurred."));
          //TODO - Sink error
        }
    }
  }

  dispose() {
    print('disposing identify stream');
    _identitySubject.close();
  }
}
