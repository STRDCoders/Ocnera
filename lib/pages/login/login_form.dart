import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/request/login_request.dart';
import 'package:ombiapp/services/network/authorization/login_bloc.dart';
import 'package:ombiapp/services/secure_storage_service.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc _bloc;

  LoginForm(this._bloc);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(
      text: secureStorage.values[StorageKeys.USERNAME.value]);
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    widget._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading
        ? Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              width: UtilsImpl.getScreenWidth(context) * 0.85,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            hintText: 'Username'),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock), hintText: 'Password'),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
              onPressed: login,
              color: Colors.orange,
              textColor: Colors.white,
              child: Text("Login"),
            )
          ])
        : SpinKitFoldingCube(
            size: 50,
            color: Colors.white,
          );
  }

  void login() async {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState.validate()) {
      await widget._bloc.login(LoginRequest(
          _usernameController.text, _passwordController.text, true, false));
      setState(() {
        _loading = false;
      });
    }
  }
}
