import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ocnera/pages/search/content_type_popup.dart';
import 'package:ocnera/pages/settings/setting_category_container.dart';
import 'package:ocnera/pages/settings/setting_container.dart';
import 'package:ocnera/services/settings_service.dart';
import 'package:ocnera/utils/input_formatter.dart';
import 'package:ocnera/widgets/confirmation_button.dart';
import 'package:ocnera/widgets/digit_form_field.dart';

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
    resetControllerData();
    WidgetsBinding.instance.addPostFrameCallback((_) => Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(('RESET_SUCCESSFUL'.tr())))));
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
                        'SETTING_PAGE_TITLE'.tr(),
                      )),
                  SettingCategoryContainer(
                      title: 'SEARCH_SYSTEM_TITLE'.tr(),
                      settings: <SettingContainer>[
                        SettingContainer(
                          title: Text('SEARCH_DELAY'.tr()),
                          subtitle: Text('SEARCH_DELAY_INFO'.tr()),
                          icon: Icon(Icons.youtube_searched_for),
                          input: DigitInputField(
                            callback: _settingsService.updateSearchDelay,
                            controller: _searchDelayController,
                            formatter: DigitTextInputFormatter(1, 5),
                          ),
                        ),
                        SettingContainer(
                          icon: Icon(Icons.ondemand_video),
                          title: Text('DEFAULT_CONTENT'.tr()),
                          subtitle: Text('DEFAULT_CONTENT_INFO'.tr()),
                          input: ContentTypePopUp(
                            defaultType: _settingsService.contentType,
                            onSelected: (contentType) async {
                              await _settingsService.updateContentType(
                                  contentType);
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
                          title: Text('RESET_DEFAULTS'.tr()),
                          subtitle: Text('RESET_DEFAULTS_INFO'.tr()),
                          inputWidth: 0.25,
                          icon: Icon(Icons.restore),
                          input: ConfirmButton(
                            title: Text('RESET_BUTTON'.tr()),
                            confirmationTitle: Text(
                                'RESET_BUTTON_CONFIRM'.tr()),
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
