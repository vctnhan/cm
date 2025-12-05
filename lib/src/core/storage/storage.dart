import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class Storage {
  Storage._privateConstructor();
  static final Storage instance = Storage._privateConstructor();

  final _box = GetStorage();

  // String
  void setString(String key, String value) => _box.write(key, value);
  String? getString(String key) => _box.read(key);

  // Int
  void setInt(String key, int value) => _box.write(key, value);
  int? getInt(String key) => _box.read(key);

  // Bool
  void setBool(String key, bool value) => _box.write(key, value);
  bool? getBool(String key) => _box.read(key);

  // Object (JSON)
  void setObject(String key, dynamic value) =>
      _box.write(key, jsonEncode(value));
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final jsonString = _box.read(key);
    if (jsonString == null) return null;
    return fromJson(jsonDecode(jsonString));
  }

  void remove(String key) => _box.remove(key);
  void clear() => _box.erase();
}
