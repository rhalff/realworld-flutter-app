// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jaguar_cache/jaguar_cache.dart';
import 'package:realworld_flutter/api/interceptors/log_interceptor.dart';
import 'package:realworld_flutter/repositories/key_value_repository/key_value_repository.dart';
import 'package:realworld_flutter/repositories/key_value_repository/key_value_shared_preferences_repository.dart';
import 'package:realworld_flutter/repositories/user/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'blocs/auth/bloc.dart';
import 'blocs/user/bloc.dart';
import 'repositories/articles/repository.dart';

class Config {}

class Application {
  KeyValueRepository secureStorage;
  Config config;
  // Cache cache;
  RealWorldApi _api;
  ArticlesRepository articlesRepository;
  UserRepository userRepository;

  AuthBloc authBloc;
  UserBloc userBloc;

  Application({
    this.config,
  });

  Future<void> setup() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    // Plugin is broken at the moment...
    // secureStorage = KeyValueSecureStorageRepository(
    secureStorage = KeyValueSharedPreferencesRepository(
        sharedPreferences: sharedPreferences);

    // cache = InMemoryCache(
    //   const Duration(
    //     hours: 5,
    //  ),
    // );

    _api = RealWorldApi(
      interceptors: [
        LogInterceptor(),
      ],
    );

    setupRepositories();

    final accessToken = await userRepository.getAccessToken();

    var isAuthenticated = false;
    if (accessToken != null) {
      try {
        _api.setApiKey('Token', accessToken);

        await userRepository.getCurrentUser();

        isAuthenticated = true;
      } catch (error) {
        await userRepository.removeAccessToken();
      }
    }

    setupBlocs(
      isAuthenticated: isAuthenticated,
    );
  }

  void setupRepositories() {
    final articlesApi = _api.getArticlesApi();
    final commentsApi = _api.getCommentsApi();
    final favoritesApi = _api.getFavoritesApi();
    final profileApi = _api.getProfileApi();
    final tagsApi = _api.getTagsApi();
    final userApi = _api.getUserAndAuthenticationApi();

    articlesRepository = ArticlesRepository(
      articlesApi: articlesApi,
      commentsApi: commentsApi,
      favoritesApi: favoritesApi,
      tagsApi: tagsApi,
    );

    userRepository = UserRepository(
      api: _api,
      secureStorage: secureStorage,
      profileApi: profileApi,
      usersApi: userApi,
    );
  }

  void setupBlocs({
    bool isAuthenticated,
  }) {
    authBloc = AuthBloc(
      initialState: isAuthenticated ? Authenticated() : NotAuthenticated(),
      userRepository: userRepository,
    );

    userBloc = UserBloc(
      userRepository: userRepository,
      authBloc: authBloc,
    );
  }

  Future<void> init() async {
    if (await userRepository.isAuthenticated()) {
      userBloc.dispatch(LoadUserEvent());
    }
  }

  void dispose() {
    authBloc.dispose();
  }
}
