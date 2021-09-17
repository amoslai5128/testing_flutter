import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SharedPreferencesStore implements IPersistStore {
  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    //Initialize the plugging
    print("LocalDB Init");
    _prefs = await SharedPreferences.getInstance();
    _prefs.getKeys();
  }

  @override
  Object? read(String key) async {
    print('LocalDB Read');
    return _prefs.getString(key);
  }

  @override
  Future<void> write<T>(String key, T value) async {
    print('LocalDB Persisted');
    _prefs.setString(key, value as String);
  }

  @override
  Future<void> delete(String key) async {
    print('LocalDB Deleted');

    _prefs.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    print('LocalDB Deleted All');
    _prefs.clear();
  }
}
