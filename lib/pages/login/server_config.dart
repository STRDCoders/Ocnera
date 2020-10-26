import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/services/login_service.dart';
import 'package:ocnera/services/network/authorization/connection_test_bloc.dart';
import 'package:ocnera/services/router.dart';
import 'package:ocnera/services/secure_storage_service.dart';
import 'package:ocnera/utils/utilsImpl.dart';

class ServerConfig extends StatefulWidget {
  @override
  _ServerConfigState createState() => _ServerConfigState();
}

class _ServerConfigState extends State<ServerConfig> {
  ConnectionTestBloc _bloc = ConnectionTestBloc();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  StreamSubscription _subscription;
  final _addressController = TextEditingController(
      text: secureStorage.values[StorageKeys.ADDRESS.value]);

  @override
  void initState() {
    super.initState();
    _subscription = _bloc.connectionStream.listen(handleStream);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UtilsImpl.getScreenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('WELCOME'.tr(),
                            style:
                                TextStyle(color: Colors.orange, fontSize: 40)),
                        Text('ENTER_SERVER_ADDRESS'.tr(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Text('INFO_STORED_WARNING'.tr()),
                        SizedBox(
                          height: 10,
                        ),
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
                                    enabled: !_loading,
                                    controller: _addressController,
                                    decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        prefixIcon: Icon(Icons.cloud),
//                          border: InputBorder.none,
                                        hintText: 'SERVER_ADDRESS'.tr()),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    !_loading
                        ? RaisedButton(
                            onPressed: () {
                              setState(() {
                                _loading = true;
                              });
                              _bloc.connect(_addressController.text);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('NEXT_BUTTON'.tr()),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          )
                        : CircularProgressIndicator()
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void handleStream(bool res) async {
    if (res) {
      await loginManager.saveAddress(_addressController.text);
      RouterService.navigate(context, Routes.ROOT);
    } else
      setState(() {
        _loading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('SERVER_CONNECTION_ERROR'.tr())));
      });
  }
}
