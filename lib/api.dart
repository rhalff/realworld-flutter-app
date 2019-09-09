library realworld_flutter.api;

import 'package:http/io_client.dart';
import 'package:jaguar_mimetype/jaguar_mimetype.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/articles_api.dart';
import 'package:realworld_flutter/api/comments_api.dart';
import 'package:realworld_flutter/api/favorites_api.dart';
import 'package:realworld_flutter/api/model/generic_error_model.dart';
import 'package:realworld_flutter/api/model/generic_error_model_errors.dart';
import 'package:realworld_flutter/api/model/login_user.dart';
import 'package:realworld_flutter/api/model/new_article.dart';
import 'package:realworld_flutter/api/model/new_comment.dart';
import 'package:realworld_flutter/api/model/new_user.dart';
import 'package:realworld_flutter/api/model/request/login_user_request.dart';
import 'package:realworld_flutter/api/model/request/new_article_request.dart';
import 'package:realworld_flutter/api/model/request/new_comment_request.dart';
import 'package:realworld_flutter/api/model/request/new_user_request.dart';
import 'package:realworld_flutter/api/model/request/update_article_request.dart';
import 'package:realworld_flutter/api/model/request/update_user_request.dart';
import 'package:realworld_flutter/api/model/response/multiple_articles_response.dart';
import 'package:realworld_flutter/api/model/response/multiple_comments_response.dart';
import 'package:realworld_flutter/api/model/response/profile_response.dart';
import 'package:realworld_flutter/api/model/response/single_article_response.dart';
import 'package:realworld_flutter/api/model/response/single_comment_response.dart';
import 'package:realworld_flutter/api/model/response/tags_response.dart';
import 'package:realworld_flutter/api/model/response/user_response.dart';
import 'package:realworld_flutter/api/model/update_article.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/api/profile_api.dart';
import 'package:realworld_flutter/api/tags_api.dart';
import 'package:realworld_flutter/api/user_and_authentication_api.dart';
import 'package:realworld_flutter/auth/api_key_auth.dart';
import 'package:realworld_flutter/auth/oauth.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/comment.dart';
import 'package:realworld_flutter/model/profile.dart';
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

final _defaultInterceptors = [ApiKeyAuthInterceptor()];

class RealWorldApi {
  List<Interceptor> interceptors;
  String basePath = 'https://conduit.productionready.io/api';
  Route _baseRoute;
  final Duration timeout;

  RealWorldApi(
      {List<Interceptor> interceptors,
      bool overrideInterceptors = false,
      String baseUrl,
      this.timeout = const Duration(minutes: 2)}) {
    _baseRoute = Route(baseUrl ?? basePath)
        .withClient(globalClient ?? IOClient()) as Route;
    if (interceptors == null) {
      this.interceptors = _defaultInterceptors;
    } else if (overrideInterceptors) {
      this.interceptors = interceptors;
    } else {
      this.interceptors = List.from(_defaultInterceptors)..addAll(interceptors);
    }

    for (var interceptor in this.interceptors) {
      _baseRoute.before(interceptor.before).after(interceptor.after);
    }
  }

  void setOAuthToken(String name, String token) {
    (_defaultInterceptors[0] as OAuthInterceptor).tokens[name] = token;
  }

  void setApiKey(String name, String apiKey) {
    _defaultInterceptors[2].apiKeys[name] = apiKey;
  }

  ArticlesApi getArticlesApi({Route base, Map<String, CodecRepo> converters}) {
    base ??= _baseRoute;
    converters ??= defaultConverters;
    return ArticlesApi(base: base, converters: converters, timeout: timeout);
  }

  CommentsApi getCommentsApi({Route base, Map<String, CodecRepo> converters}) {
    base ??= _baseRoute;
    converters ??= defaultConverters;
    return CommentsApi(base: base, converters: converters, timeout: timeout);
  }

  TagsApi getTagsApi({Route base, Map<String, CodecRepo> converters}) {
    base ??= _baseRoute;
    converters ??= defaultConverters;
    return TagsApi(base: base, converters: converters, timeout: timeout);
  }

  FavoritesApi getFavoritesApi(
      {Route base, Map<String, CodecRepo> converters}) {
    base ??= _baseRoute;
    converters ??= defaultConverters;
    return FavoritesApi(base: base, converters: converters, timeout: timeout);
  }

  ProfileApi getProfileApi({Route base, Map<String, CodecRepo> converters}) {
    base ??= _baseRoute;
    converters ??= defaultConverters;
    return ProfileApi(base: base, converters: converters, timeout: timeout);
  }

  UserAndAuthenticationApi getUserAndAuthenticationApi(
      {Route base, Map<String, CodecRepo> converters}) {
    base ??= _baseRoute;
    converters ??= defaultConverters;
    return UserAndAuthenticationApi(
        base: base, converters: converters, timeout: timeout);
  }
}
