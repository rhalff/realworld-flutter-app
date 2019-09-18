import 'dart:async';

import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/response/profile_response.dart';

part 'profile_api.jretro.dart';

@GenApiClient()
class ProfileApi extends ApiClient with _$ProfileApiClient {
  @override
  final Route base;
  @override
  final Map<String, CodecRepo> converters;
  final Duration timeout;

  ProfileApi({
    this.base,
    this.converters,
    this.timeout = const Duration(minutes: 2),
  });

  /// Follow a user
  ///
  /// Follow a user by username
  @PostReq(
    path: '/profiles/:username/follow',
    metadata: {
      'auth': true,
    },
  )
  @override
  Future<ProfileResponse> followUserByUsername(
    @PathParam('username') String username,
  ) {
    return super.followUserByUsername(username).timeout(timeout);
  }

  /// Get a profile
  ///
  /// Get a profile of a user of the system. Auth is optional
  @GetReq(path: '/profiles/:username')
  @override
  Future<ProfileResponse> getProfileByUsername(
    @PathParam('username') String username,
  ) {
    return super.getProfileByUsername(username).timeout(timeout);
  }

  /// Unfollow a user
  ///
  /// Unfollow a user by username
  @DeleteReq(
    path: '/profiles/:username/follow',
    metadata: {
      'auth': true,
    },
  )
  @override
  Future<ProfileResponse> unfollowUserByUsername(
    @PathParam('username') String username,
  ) {
    return super.unfollowUserByUsername(username).timeout(timeout);
  }
}
