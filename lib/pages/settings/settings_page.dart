import 'package:flutter/material.dart';
import 'package:ombiapp/pages/settings/setting_category_container.dart';
import 'package:ombiapp/pages/settings/setting_container.dart';
import 'package:ombiapp/services/settings_service.dart';
import 'package:ombiapp/utils/input_formatter.dart';
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
  void dispose() {
    _searchDelayController.dispose();
    super.dispose();
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
          SettingCategoryContainer(
              title: 'Search System',
              settings: <SettingContainer>[
                SettingContainer(
                  title: Text('Search Delay'),
                  icon: Icon(Icons.youtube_searched_for),
                  input: DigitInputField(
                    callback: _settingsService.updateSearchDelay,
                    controller: _searchDelayController,
                    formatter: DigitTextInputFormatter(1, 5),
                  ),
                ),
              ]),
          SizedBox(
            height: 5,
          ),
        ])));
  }
}
