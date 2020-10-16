import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombiapp/model/network_error.dart';
import 'package:ombiapp/model/response/LoginResponseDto.dart';
import 'package:ombiapp/pages/login/login_form.dart';
import 'package:ombiapp/services/login_service.dart';
import 'package:ombiapp/services/network/authorization/login_bloc.dart';
import 'package:ombiapp/services/router.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc;

  @override
  void initState() {
    super.initState();
    print("Init login bloc");
    _bloc = LoginBloc();
  }

  @override
  void dispose() {
    print("disposing login page");
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 20),
                child: Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
              StreamBuilder(
                  stream: _bloc.loginStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<LoginResponseDto> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        if (snapshot.hasError) {
                          NetworkError error = snapshot.error;
                          WidgetsBinding.instance.addPostFrameCallback((_) =>
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(error.message))));
                        }
                        break;
                      case ConnectionState.done:
                        print(snapshot.data);
                        login(snapshot.data);
                        break;
                      default:
                        {}
                    }
                    return LoginForm(_bloc);
                  }),
            ],
          ),
          FlatButton(
            child: Text("Switch Server"),
            onPressed: () async {
              await loginManager.removeAddress();
              RouterService.navigate(context, Routes.ROOT);
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }

  void login(LoginResponseDto loginResponsePodo) async {
    await loginManager.login(loginResponsePodo);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => RouterService.navigate(context, Routes.ROOT));
  }
}
