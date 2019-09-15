import 'dart:async';

import 'package:meta/meta.dart';

abstract class KeyValueRepository {
  Future<String> read({@required String key});

  Future<void> write({@required String key, @required String value});

  Future<void> delete({@required String key});
}
