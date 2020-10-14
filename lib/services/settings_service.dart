import 'package:ombiapp/services/local_settings.dart';

class SettingsService {

  String get searchDelay => localSettings.searchDelay.toString();
  Future<void> updateLearnImgCount(v) async {
    await localSettings.updateSearchDelay(int.parse(v));
  }

}