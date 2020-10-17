import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/services/local_settings.dart';

class SettingsService {
  String get searchDelay => localSettings.searchDelay.toString();

  MediaContentType get contentType => localSettings.contentType;

  Future<void> updateSearchDelay(v) async {
    await localSettings.updateSearchDelay(int.parse(v));
  }

  Future<void> updateContentType(MediaContentType mediaContentType) async {
    await localSettings.updateContentType(mediaContentType);
  }

  Future<void> resetSettingToDefault() async {
    await localSettings.resetDefault();
  }
}
