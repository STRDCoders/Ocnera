import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';
import 'package:ombiapp/services/settings_service.dart';
import 'package:ombiapp/utils/input_formatter.dart';
import 'package:ombiapp/utils/theme.dart';
import 'package:ombiapp/utils/utilsImpl.dart';
import 'package:ombiapp/widgets/digit_form_field.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsService _settingsService = SettingsService();
  TextEditingController _searchDelayController;

  @override
  void initState() {
    super.initState();
    _searchDelayController =
        TextEditingController(text: _settingsService.searchDelay);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              AppBar(
                  title: Text(
                "Settings Page",
              )),
                  Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 8),
                              child: Text(
                                "Search System",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              )),
                          ListTileMoreCustomizable(
                              horizontalTitleGap: 0.5,
                              leading: Icon(
                                Icons.youtube_searched_for,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Search Delay'),
                                  Text(
                                    'Delay duration should be between 1-5 seconds',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black26),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                  width: UtilsImpl.getScreenWidth(context) * 0.15,
                                  child: DigitInputField(
                                    callback: (v) => null,
                                    controller: _searchDelayController,
                                    formatter: DigitTextInputFormatter(1, 5),
                                  )
                              )
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
            ])));
  }
}
