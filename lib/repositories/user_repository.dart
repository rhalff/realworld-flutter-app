import 'package:realworld_flutter/api/model/login_user.dart';
import 'package:realworld_flutter/api/model/new_user.dart';
import 'package:realworld_flutter/api/model/request/login_user_request.dart';
import 'package:realworld_flutter/api/model/request/new_user_request.dart';
import 'package:realworld_flutter/api/model/request/update_user_request.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/api/profile_api.dart';
import 'package:realworld_flutter/api/user_and_authentication_api.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/model/user.dart';

class UserRepository {
  ProfileApi profileApi;
  UserAndAuthenticationApi usersApi;
  UserRepository({
    this.profileApi,
    this.usersApi,
  });

  Future<User> createUser(NewUser user) async {
    final result = await usersApi.createUser(NewUserRequest(user: user));

    return result.user;
  }

  Future<User> getCurrentUser() async {
    final result = await usersApi.getCurrentUser();

    return result.user;
  }

  Future<User> login(LoginUser user) async {
    // where is our token? in the header?
    final result = await usersApi.login(LoginUserRequest(user: user));

    return result.user;
  }

  Future<User> updateCurrentUser(UpdateUser user) async {
    final result = await usersApi.updateCurrentUser(
      UpdateUserRequest(user: user),
    );

    return result.user;
  }

  Future<Profile> getProfileByUsername(String username) async {
    final result = await profileApi.getProfileByUsername(username);

    return result.profile;
  }

  Future<Profile> followUser(String username) async {
    final result = await profileApi.followUserByUsername(username);

    return result.profile;
  }

  Future<Profile> unFollowUser(String username) async {
    final result = await profileApi.unfollowUserByUsername(username);

    return result.profile;
  }
}
