// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jaguar_cache/jaguar_cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:realworld_flutter/blocs/articles/articles_events.dart';
import 'package:realworld_flutter/repositories/user_repository.dart';

import 'api.dart';
import 'blocs/article/article_bloc.dart';
import 'blocs/articles/articles_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/user/blocs.dart';
import 'repositories/articles_repository.dart';

class Config {}

class Application {
  // SharedPreferences sharedPreferences;
  FlutterSecureStorage secureStorage;
  Config config;
  // Cache cache;
  RealWorldApi _api;
  ArticlesRepository articlesRepository;
  UserRepository userRepository;

  AuthBloc authBloc;
  UserBloc userBloc;
  ArticlesBloc articlesBloc;
  ArticleBloc articleBloc;

  Application({
    this.config,
  });

  Future<void> setup() async {
    // sharedPreferences = await SharedPreferences.getInstance();

    secureStorage = FlutterSecureStorage();

    // cache = InMemoryCache(
    //   const Duration(
    //     hours: 5,
    //  ),
    // );

    _api = RealWorldApi(
      interceptors: [
        //  LogInterceptor(),
      ],
    );

    setupRepositories();

    final accessToken = await userRepository.getAccessToken();

    var isAuthenticated = false;
    if (accessToken != null) {
      try {
        await userRepository.getCurrentUser();

        _api
          ..setOAuthToken('Token', accessToken)
          ..setApiKey('Token', accessToken);

        isAuthenticated = true;
      } catch (_) {
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

    articlesBloc = ArticlesBloc(
      articlesRepository: articlesRepository,
    );

    articleBloc = ArticleBloc(
      articlesRepository: articlesRepository,
    );
  }

  Future<void> init() async {
    articlesBloc.dispatch(LoadArticlesEvent());

    if (await userRepository.isAuthenticated()) {
      userBloc.dispatch(LoadUserEvent());
    }
  }

  void dispose() {
    articlesBloc.dispose();
    authBloc.dispose();
  }
}
