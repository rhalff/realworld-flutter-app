import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:realworld_flutter/api.dart';
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
import 'package:realworld_flutter/repositories/parse_jwt.dart';

final _authKey = 'auth';

class UserRepository {
  final RealWorldApi api;
  final ProfileApi profileApi;
  final UserAndAuthenticationApi usersApi;
  final FlutterSecureStorage secureStorage;
  UserRepository({
    this.api,
    this.profileApi,
    this.usersApi,
    this.secureStorage,
  });

  Future<User> signUp(NewUser user) async {
    final result = await usersApi.createUser(NewUserRequest(user: user));

    return result.user;
  }

  Future<User> getCurrentUser() async {
    final result = await usersApi.getCurrentUser();

    return result.user;
  }

  Future<User> login(LoginUser user) async {
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

  Future<void> setAccessToken(String accessToken) async {
    await secureStorage.write(key: _authKey, value: accessToken);

    api
      ..setOAuthToken('Token', accessToken)
      ..setApiKey('Token', accessToken);
  }

  Future<String> getAccessToken() async {
    final token = await secureStorage.read(key: _authKey);

    if (token == null) return null;

    final jwt = parseJwt(token);

    final expires =
        DateTime.fromMillisecondsSinceEpoch((jwt['exp'] as int) * 1000);

    if (expires.isBefore(DateTime.now())) {
      await removeAccessToken();

      return null;
    }

    return token;
  }

  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();

    return token != null;
  }

  Future<void> removeAccessToken() async {
    api
      ..setOAuthToken('Token', null)
      ..setApiKey('Token', null);

    return secureStorage.delete(key: _authKey);
  }
}
