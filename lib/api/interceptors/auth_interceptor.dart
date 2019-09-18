import 'dart:async';

import 'package:jaguar_retrofit/jaguar_retrofit.dart';

class AuthInterceptor extends Interceptor {
  String apiKey;

  @override
  FutureOr<void> before(RouteBase route) {
    if (route.metadataMap.containsKey('auth') &&
        route.metadataMap['auth'] == true &&
        apiKey != null) {
      route.header('Authorization', 'Token $apiKey');
    }
    super.before(route);
  }

  @override
  FutureOr after(StringResponse response) {
    return Future.value(response);
  }
}
