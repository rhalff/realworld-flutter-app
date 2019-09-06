library realworld_flutter.api;

import 'package:http/io_client.dart';
import 'package:jaguar_mimetype/jaguar_mimetype.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/articles_api.dart';
import 'package:realworld_flutter/api/comments_api.dart';
import 'package:realworld_flutter/api/default_api.dart';
import 'package:realworld_flutter/api/favorites_api.dart';
import 'package:realworld_flutter/api/model/generic_error_model.dart';
import 'package:realworld_flutter/api/model/generic_error_model_errors.dart';
import 'package:realworld_flutter/api/model/login_user.dart';
import 'package:realworld_flutter/api/model/new_article.dart';
import 'package:realworld_flutter/api/model/new_comment.dart';
import 'package:realworld_flutter/api/model/new_user.dart';
import 'package:realworld_flutter/api/model/update_article.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/api/profile_api.dart';
import 'package:realworld_flutter/api/user_and_authentication_api.dart';
import 'package:realworld_flutter/auth/api_key_auth.dart';
import 'package:realworld_flutter/auth/basic_auth.dart';
import 'package:realworld_flutter/auth/oauth.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/comment.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/model/request/login_user_request.dart';
import 'package:realworld_flutter/model/request/new_article_request.dart';
import 'package:realworld_flutter/model/request/new_comment_request.dart';
import 'package:realworld_flutter/model/request/new_user_request.dart';
import 'package:realworld_flutter/model/request/update_article_request.dart';
import 'package:realworld_flutter/model/request/update_user_request.dart';
import 'package:realworld_flutter/model/response/multiple_articles_response.dart';
import 'package:realworld_flutter/model/response/multiple_comments_response.dart';
import 'package:realworld_flutter/model/response/profile_response.dart';
import 'package:realworld_flutter/model/response/single_article_response.dart';
import 'package:realworld_flutter/model/response/single_comment_response.dart';
import 'package:realworld_flutter/model/response/tags_response.dart';
import 'package:realworld_flutter/model/response/user_response.dart';
import 'package:realworld_flutter/model/user.dart';

final _jsonJaguarRepo = JsonRepo()
  ..add(ArticleSerializer())
  ..add(CommentSerializer())
  ..add(GenericErrorModelSerializer())
  ..add(GenericErrorModelErrorsSerializer())
  ..add(LoginUserSerializer())
  ..add(LoginUserRequestSerializer())
  ..add(MultipleArticlesResponseSerializer())
  ..add(MultipleCommentsResponseSerializer())
  ..add(NewArticleSerializer())
  ..add(NewArticleRequestSerializer())
  ..add(NewCommentSerializer())
  ..add(NewCommentRequestSerializer())
  ..add(NewUserSerializer())
  ..add(NewUserRequestSerializer())
  ..add(ProfileSerializer())
  ..add(ProfileResponseSerializer())
  ..add(SingleArticleResponseSerializer())
  ..add(SingleCommentResponseSerializer())
  ..add(TagsResponseSerializer())
  ..add(UpdateArticleSerializer())
  ..add(UpdateArticleRequestSerializer())
  ..add(UpdateUserSerializer())
  ..add(UpdateUserRequestSerializer())
  ..add(UserSerializer())
  ..add(UserResponseSerializer());
final Map<String, CodecRepo> defaultConverters = {
  MimeTypes.json: _jsonJaguarRepo,
};

final _defaultInterceptors = [
  OAuthInterceptor(),
  BasicAuthInterceptor(),
  ApiKeyAuthInterceptor()
];

class RealworldFlutter {
  List<Interceptor> interceptors;
  String basePath = "http://localhost/api";
  Route _baseRoute;
  final Duration timeout;

  /**
    * Add custom global interceptors, put overrideInterceptors to true to set your interceptors only (auth interceptors will not be added)
    */
  RealworldFlutter(
      {List<Interceptor> interceptors,
      bool overrideInterceptors = false,
      String baseUrl,
      this.timeout = const Duration(minutes: 2)}) {
    _baseRoute =
        Route(baseUrl ?? basePath).withClient(globalClient ?? IOClient());
    if (interceptors == null) {
      this.interceptors = _defaultInterceptors;
    } else if (overrideInterceptors) {
      this.interceptors = interceptors;
    } else {
      this.interceptors = List.from(_defaultInterceptors)..addAll(interceptors);
    }

    this.interceptors.forEach((interceptor) {
      _baseRoute.before(interceptor.before);
      _baseRoute.after(interceptor.after);
    });
  }

  void setOAuthToken(String name, String token) {
    (_defaultInterceptors[0] as OAuthInterceptor).tokens[name] = token;
  }

  void setBasicAuth(String name, String username, String password) {
    (_defaultInterceptors[1] as BasicAuthInterceptor).authInfo[name] =
        BasicAuthInfo(username, password);
  }

  void setApiKey(String name, String apiKey) {
    (_defaultInterceptors[2] as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
  }

  /**
    * Get ArticlesApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
  ArticlesApi getArticlesApi({Route base, Map<String, CodecRepo> converters}) {
    if (base == null) {
      base = _baseRoute;
    }
    if (converters == null) {
      converters = defaultConverters;
    }
    return ArticlesApi(base: base, converters: converters, timeout: timeout);
  }

  /**
    * Get CommentsApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
  CommentsApi getCommentsApi({Route base, Map<String, CodecRepo> converters}) {
    if (base == null) {
      base = _baseRoute;
    }
    if (converters == null) {
      converters = defaultConverters;
    }
    return CommentsApi(base: base, converters: converters, timeout: timeout);
  }

  /**
    * Get DefaultApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
  DefaultApi getDefaultApi({Route base, Map<String, CodecRepo> converters}) {
    if (base == null) {
      base = _baseRoute;
    }
    if (converters == null) {
      converters = defaultConverters;
    }
    return DefaultApi(base: base, converters: converters, timeout: timeout);
  }

  /**
    * Get FavoritesApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
  FavoritesApi getFavoritesApi(
      {Route base, Map<String, CodecRepo> converters}) {
    if (base == null) {
      base = _baseRoute;
    }
    if (converters == null) {
      converters = defaultConverters;
    }
    return FavoritesApi(base: base, converters: converters, timeout: timeout);
  }

  /**
    * Get ProfileApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
  ProfileApi getProfileApi({Route base, Map<String, CodecRepo> converters}) {
    if (base == null) {
      base = _baseRoute;
    }
    if (converters == null) {
      converters = defaultConverters;
    }
    return ProfileApi(base: base, converters: converters, timeout: timeout);
  }

  /**
    * Get UserAndAuthenticationApi instance, base route and serializer can be overridden by a given but be careful,
    * by doing that all interceptors will not be executed
    */
  UserAndAuthenticationApi getUserAndAuthenticationApi(
      {Route base, Map<String, CodecRepo> converters}) {
    if (base == null) {
      base = _baseRoute;
    }
    if (converters == null) {
      converters = defaultConverters;
    }
    return UserAndAuthenticationApi(
        base: base, converters: converters, timeout: timeout);
  }
}
