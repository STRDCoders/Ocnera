import 'package:flutter/material.dart';
import 'package:ombiapp/pages/search/content_type_popup.dart';
import 'package:ombiapp/pages/settings/setting_category_container.dart';
import 'package:ombiapp/pages/settings/setting_container.dart';
import 'package:ombiapp/services/settings_service.dart';
import 'package:ombiapp/utils/input_formatter.dart';
import 'package:ombiapp/widgets/confirmation_button.dart';
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
    resetControllerData();
  }

  @override
  void dispose() {
    _searchDelayController.dispose();
    super.dispose();
  }

  void resetControllerData() {
    _searchDelayController =
        TextEditingController(text: _settingsService.searchDelay);
  }

  Future<void> resetDefaultSettings() async {
    await _settingsService.resetSettingToDefault();
    await resetControllerData();
    WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
        .showSnackBar(SnackBar(
            content: Text(('Reset to default settings successfully!')))));
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
            'Settings Page',
          )),
          SettingCategoryContainer(
              title: 'Search System',
              settings: <SettingContainer>[
                SettingContainer(
                  title: Text('Search Delay'),
                  subtitle: Text('Delay should be between 1-5 seconds'),
                  icon: Icon(Icons.youtube_searched_for),
                  input: DigitInputField(
                    callback: _settingsService.updateSearchDelay,
                    controller: _searchDelayController,
                    formatter: DigitTextInputFormatter(1, 5),
                  ),
                ),
                SettingContainer(
                  icon: Icon(Icons.ondemand_video),
                  title: Text('Default Content'),
                  subtitle: Text('Default content to load on search'),
                  input: ContentTypePopUp(
                    defaultType: _settingsService.contentType,
                    onSelected: (contentType) async {
                      await _settingsService.updateContentType(contentType);
                      setState(() {});
                    },
                  ),
                ),
              ]),
          SizedBox(
            height: 5,
          ),
          SettingCategoryContainer(
            title: 'Global',
            settings: [
              SettingContainer(
                  title: Text('Reset Default'),
                  subtitle: Text('Double tap to reset settings'),
                  inputWidth: 0.25,
                  icon: Icon(Icons.restore),
                  input: ConfirmButton(
                    title: Text('Reset'),
                    confirmationTitle: Text('Confirm'),
                    onPressed: () {
                      setState(() {
                        resetDefaultSettings();
                      });
                    },
                  ))
            ],
          ),
        ])));
  }
}
