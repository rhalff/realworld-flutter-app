// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_and_authentication_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$UserAndAuthenticationApiClient implements ApiClient {
  final String basePath = "";
  Future<UserResponse> createUser(NewUserRequest body) async {
    var req =
        base.post.path(basePath).path("/users").json(jsonConverter.to(body));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<UserResponse> getCurrentUser() async {
    var req = base.get
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/user");
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<UserResponse> login(LoginUserRequest body) async {
    var req = base.post
        .path(basePath)
        .path("/users/login")
        .json(jsonConverter.to(body));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<UserResponse> updateCurrentUser(UpdateUserRequest body) async {
    var req = base.put
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/user")
        .json(jsonConverter.to(body));
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
