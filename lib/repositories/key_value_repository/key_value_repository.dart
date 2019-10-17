import 'dart:async';

abstract class KeyValueRepository {
  Future<String> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}
