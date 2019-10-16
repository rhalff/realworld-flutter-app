part of repositories.user;

final _authKey = 'auth';

class UserRepository extends EventEmitter {
  final RealWorldApi api;
  final ProfileApi profileApi;
  final UserAndAuthenticationApi usersApi;
  final KeyValueRepository secureStorage;
  UserRepository({
    this.api,
    this.profileApi,
    this.usersApi,
    this.secureStorage,
  });

  Future<User> signUp(NewUser user) async {
    final result = await usersApi.createUser(NewUserRequest(user: user));

    fire(UserCreatedEvent(user: result.user));

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

    fire(UserUpdatedEvent(user: result.user));

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
    await secureStorage.write(_authKey, accessToken);

    api.setApiKey('Token', accessToken);
  }

  Future<String> getAccessToken() async {
    final token = await secureStorage.read(_authKey);

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
    api.setApiKey('Token', null);

    return secureStorage.delete(_authKey);
  }
}
