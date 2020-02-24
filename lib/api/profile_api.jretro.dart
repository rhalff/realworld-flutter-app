// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$ProfileApiClient implements ApiClient {
  final String basePath = "";

  Future<ProfileResponse> followUserByUsername(String username) async {
    var req = base.post
        .metadata({
          "auth": true,
        })
        .path(basePath)
        .path("/profiles/:username/follow")
        .pathParams("username", username);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<ProfileResponse> getProfileByUsername(String username) async {
    var req = base.get
        .path(basePath)
        .path("/profiles/:username")
        .pathParams("username", username);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<ProfileResponse> unfollowUserByUsername(String username) async {
    var req = base.delete
        .metadata({
          "auth": true,
        })
        .path(basePath)
        .path("/profiles/:username/follow")
        .pathParams("username", username);
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
