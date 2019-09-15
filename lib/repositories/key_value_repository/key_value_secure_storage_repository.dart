import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'key_value_repository.dart';

class KeyValueSecureStorageRepository implements KeyValueRepository {
  static const MethodChannel _channel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  @override
  Future<String> read({@required String key}) async {
    return _channel.invokeMethod('read', <String, String>{'key': key});
  }

  @override
  Future<void> write({@required String key, @required String value}) async =>
      _channel
          .invokeMethod('write', <String, String>{'key': key, 'value': value});

  @override
  Future<void> delete({@required String key}) =>
      _channel.invokeMethod('delete', <String, String>{'key': key});
}
