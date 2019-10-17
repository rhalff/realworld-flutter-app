import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_repository.dart';

class KeyValueSharedPreferencesRepository implements KeyValueRepository {
  SharedPreferences sharedPreferences;

  KeyValueSharedPreferencesRepository({
    this.sharedPreferences,
  });

  @override
  Future<void> write(String key, String value) {
    sharedPreferences.setString(key, value);

    return Future.value();
  }

  @override
  Future<String> read(String key) {
    return Future.value(sharedPreferences.getString(key));
  }

  @override
  Future<void> delete(String key) {
    sharedPreferences.remove(key);

    return Future.value();
  }
}
