import 'package:enum_to_string/enum_to_string.dart';
import 'package:ombiapp/contracts/media_content_type.dart';
import 'package:ombiapp/utils/logger.dart';
import 'package:ombiapp/utils/unsupported_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalSettingsType { SEARCH_DELAY, CONTENT_TYPE }

extension LocalSettingsTypeExtension on LocalSettingsType {
  static String _value(LocalSettingsType val) {
    switch (val) {
      case LocalSettingsType.SEARCH_DELAY:
        return "search_delay";
        break;
      case LocalSettingsType.CONTENT_TYPE:
        return "content_type";
      default:
        throw UnsupportedException();
    }
  }

  String get value => _value(this);
}

class LocalSettings {
  SharedPreferences _prefs;

  var _defaultValues = <LocalSettingsType, dynamic>{
    LocalSettingsType.SEARCH_DELAY: 1,
    LocalSettingsType.CONTENT_TYPE:
        EnumToString.convertToString(MediaContentType.MOVIE)
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

  MediaContentType get contentType => EnumToString.fromString(
      MediaContentType.values,
      _prefs.getString(LocalSettingsType.CONTENT_TYPE.value));

  Future<void> updateSearchDelay(int val) async {
    await _prefs.setInt(LocalSettingsType.SEARCH_DELAY.value, val);
  }

  Future<void> updateContentType(MediaContentType contentType) async {
    await _prefs.setString(LocalSettingsType.CONTENT_TYPE.value,
        EnumToString.convertToString(contentType));
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
