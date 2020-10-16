import 'package:ombiapp/utils/logger.dart';
import 'package:ombiapp/utils/unsupported_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalSettingsType { SEARCH_DELAY }

extension LocalSettingsTypeExtension on LocalSettingsType {
  static String _value(LocalSettingsType val) {
    switch (val) {
      case LocalSettingsType.SEARCH_DELAY:
        return "search_delay";
        break;
      default:
        throw UnsupportedException();
    }
  }

  String get value => _value(this);
}

class LocalSettings {
  SharedPreferences _prefs;

  var _defaultValues = <LocalSettingsType, dynamic>{
    LocalSettingsType.SEARCH_DELAY: 1
  };

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _setDefault();
  }

  Future<void> _createDefault(key, value) async {
    var type = value.runtimeType.toString();
    print("Key: $key , Val: $value, Type: $type");
    print(type);
    switch (type) {
      case 'bool':
        await _prefs.setBool(key, value);
        break;
      case 'int':
        await _prefs.setInt(key, value);
        break;
      case 'String':
        await _prefs.setString(key, value);
        break;
      default:
        throw UnsupportedException();
        break;
    }
  }

  int get searchDelay => _prefs.getInt(LocalSettingsType.SEARCH_DELAY.value);

  Future<void> updateSearchDelay(int val) async {
    await _prefs.setInt(LocalSettingsType.SEARCH_DELAY.value, val);
  }

  Future<void> resetDefault() async {
    _defaultValues.forEach((k, v) async {
      await _prefs.remove(k.value);
    });
    _setDefault();
  }

  Future<void> _setDefault() async {
    _defaultValues.forEach((key, value) async {
      if (!_prefs.containsKey(key.value)) {
        logger.d("CREATING CONFIG FOR: ${key.value}, value: $value");
        await _createDefault(key.value, value);
      }
    });
  }
}

LocalSettings localSettings = LocalSettings();
