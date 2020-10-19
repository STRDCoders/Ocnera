import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ocnera/model/response/login_response.dart';
import 'package:ocnera/pages/login/login_form.dart';
import 'package:ocnera/services/login_service.dart';
import 'package:ocnera/services/network/authorization/login_bloc.dart';
import 'package:ocnera/services/router.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _bloc;
  LoginForm _form;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc();
    _form = LoginForm(_bloc);
    _subscription = _bloc.loginStream.listen(login, onError: loginFailed);
  }

  @override
  void dispose() {
    _subscription.cancel();
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
                child: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
              _form,
            ],
          ),
          FlatButton(
            child: Text('Switch Server'),
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

  loginFailed(data) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(data.message)));
  }

  Future<void> login(LoginResponseDto loginResponsePodo) async {
    await loginManager.login(loginResponsePodo);
    RouterService.navigate(context, Routes.ROOT);
  }
}
