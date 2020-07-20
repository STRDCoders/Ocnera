import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/services/network/login_bloc.dart';
import 'package:ombiapp/services/secure_storage.dart';
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
  final _addressController = TextEditingController(
      text: secureStorage.values[StorageKeys.ADDRESS.value]);

  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
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
//                          border: InputBorder.none,
                            hintText: 'Username'),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock), hintText: 'Password'),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _addressController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(
                              RegExp(r"[\d\.]{1,15}$")),
                        ],
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.cloud),
                            hintText: 'Server Address'),
                      )
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
      await widget._bloc.login(LoginRequestPodo(_addressController.text,
          _usernameController.text, _passwordController.text, true, false));
      _loading = false;
      print("ended");
    }
  }
}
