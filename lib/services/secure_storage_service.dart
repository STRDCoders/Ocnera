import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ocnera/utils/unsupported_exception.dart';

enum StorageKeys { TOKEN, USERNAME, ADDRESS }

extension RoutesExtension on StorageKeys {
  static String _value(StorageKeys val) {
    switch (val) {
      case StorageKeys.TOKEN:
        return "token";
        break;
      case StorageKeys.USERNAME:
        return "username";
        break;
      case StorageKeys.ADDRESS:
        return "address";
        break;
      default:
        throw UnsupportedException();
    }
  }

  String get value => _value(this);
}

class SecureStorage {
  final _storage = FlutterSecureStorage();
  Map<String, String> _values;

  init() async {
    _values = await _storage.readAll();
  }

  saveData(String key, String val) async {
    logger.d("Saving secure data '$key' ");
    _values[key] = val;
    await _storage.write(key: key, value: val);
  }

  Future<void> removeData(String key) async {
    logger.d("removing $key");
    _values.remove(key);
    await _storage.delete(key: key);
  }

  Map<String, String> get values => _values;

  removeAllData() async {
    logger.d("Deleting all saved data");
    _values = Map();
    await _storage.deleteAll();
  }
}

final secureStorage = new SecureStorage();
