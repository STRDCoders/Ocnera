import 'package:ombiapp/model/network_error.dart';
import 'package:ombiapp/model/request/login_request.dart';
import 'package:ombiapp/model/response/login_response.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:ombiapp/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _loginSubject = PublishSubject<LoginResponseDto>();

  Stream<LoginResponseDto> get loginStream => _loginSubject.stream;

  login(LoginRequest loginRequestPodo) async {
    LoginResponseDto res = await repo.login(loginRequestPodo);
    switch (res.statusCode) {
      case 200:
        {
          _loginSubject.sink.add(res);
          _loginSubject.sink.close();
        }
        break;
      case 401:
        {
          _loginSubject.sink.addError(NetworkError(
              res.statusCode, "One of the credentials is incorrect!"));
        }
        break;
      default:
        {
          _loginSubject.sink.addError(
              NetworkError(res.statusCode, "An unknown error has occurred."));
        }
    }
  }

  dispose() {
    logger.d('disposing login stream');
    _loginSubject.close();
  }
}
