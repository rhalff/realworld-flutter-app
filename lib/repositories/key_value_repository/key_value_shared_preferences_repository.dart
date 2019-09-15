import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_repository.dart';

class KeyValueSharedPreferencesRepository implements KeyValueRepository {
  SharedPreferences sharedPreferences;

  KeyValueSharedPreferencesRepository({
    this.sharedPreferences,
  });

  @override
  Future<void> write({
    @required String key,
    @required String value,
  }) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<String> read({
    @required String key,
  }) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> delete({
    @required String key,
  }) async {
    await sharedPreferences.remove(key);
  }
}
