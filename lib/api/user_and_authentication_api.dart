import 'dart:async';

import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/request/login_user_request.dart';
import 'package:realworld_flutter/api/model/request/new_user_request.dart';
import 'package:realworld_flutter/api/model/request/update_user_request.dart';
import 'package:realworld_flutter/api/model/response/user_response.dart';

part 'user_and_authentication_api.jretro.dart';

@GenApiClient()
class UserAndAuthenticationApi extends ApiClient
    with _$UserAndAuthenticationApiClient {
  @override
  final Route base;
  @override
  final Map<String, CodecRepo> converters;
  final Duration timeout;

  UserAndAuthenticationApi({
    this.base,
    this.converters,
    this.timeout = const Duration(minutes: 2),
  });

  /// Register a new user
  ///
  /// Register a new user
  @PostReq(path: '/users')
  @override
  Future<UserResponse> createUser(@AsJson() NewUserRequest body) {
    return super.createUser(body).timeout(timeout);
  }

  /// Get current user
  ///
  /// Gets the currently logged-in user
  @override
  @GetReq(path: '/users', metadata: {
    'auth': [
      {
        'type': 'apiKey',
        'name': 'Token',
        'keyName': 'Authorization',
        'where': 'header'
      }
    ]
  })
  @override
  Future<UserResponse> getCurrentUser() {
    return super.getCurrentUser().timeout(timeout);
  }

  /// Existing user login
  ///
  /// Login for existing user
  @PostReq(path: '/users/login')
  @override
  Future<UserResponse> login(@AsJson() LoginUserRequest body) {
    return super.login(body).timeout(timeout);
  }

  /// Update current user
  ///
  /// Updated user information for current user
  @PutReq(path: '/users', metadata: {
    'auth': [
      {
        'type': 'apiKey',
        'name': 'Token',
        'keyName': 'Authorization',
        'where': 'header'
      }
    ]
  })
  @override
  Future<UserResponse> updateCurrentUser(@AsJson() UpdateUserRequest body) {
    return super.updateCurrentUser(body).timeout(timeout);
  }
}
