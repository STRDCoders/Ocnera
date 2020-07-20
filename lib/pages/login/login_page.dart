import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ombiapp/model/request/login.dart';
import 'package:ombiapp/model/response/LoginResponsePodo.dart';
import 'package:ombiapp/services/network/login_bloc.dart';
import 'package:ombiapp/services/network/repository.dart';
import 'package:ombiapp/utils/utilsImpl.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  LoginBloc _bloc;

  @override
  void initState() {
    print("Init login bloc");
    _bloc = LoginBloc();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(245, 31, 31, 31),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(245, 31, 31, 31),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Login Page",
                  style: TextStyle(color: Colors.orange, fontSize: 40)),
              SizedBox(height: 50),
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
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity),
//                          border: InputBorder.none,
                              hintText: 'Username'),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password'),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              StreamBuilder(
                  stream: _bloc.loginStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<LoginResponsePodo> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      _isLoading = false;
                    }
                    if (snapshot.hasData) print(snapshot.data);
                    if (!_isLoading)
                      return RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            _bloc.login(LoginRequestPodo(
                                _usernameController.text,
                                _passwordController.text,
                                true,
                                false));
                          }
                        },
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text("Login"),
                      );
                    else
                      return SpinKitThreeBounce(
                        size: 40,
                        color: Colors.white,
                      );
                  }),
            ],
          )),
        ),
      ),
    );
  }
}
