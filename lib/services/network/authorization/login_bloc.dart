import 'package:ombiapp/model/network_error.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/response/LoginResponseDto.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _loginSubject = PublishSubject<LoginResponseDto>();

  Stream<LoginResponseDto> get loginStream => _loginSubject.stream;

  login(LoginRequestPodo loginRequestPodo) async {
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
    print('disposing login stream');
    _loginSubject.close();
  }
}
