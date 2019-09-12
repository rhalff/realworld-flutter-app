import 'dart:async';

import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/response/single_article_response.dart';

part 'favorites_api.jretro.dart';

@GenApiClient()
class FavoritesApi extends ApiClient with _$FavoritesApiClient {
  @override
  final Route base;
  @override
  final Map<String, CodecRepo> converters;
  final Duration timeout;

  FavoritesApi({
    this.base,
    this.converters,
    this.timeout = const Duration(minutes: 2),
  });

  /// Favorite an article
  ///
  /// Favorite an article. Auth is required
  @PostReq(
    path: '/articles/:slug/favorite',
    metadata: {
      'auth': [
        {
          'type': 'apiKey',
          'name': 'Token',
          'keyName': 'Authorization',
          'where': 'header'
        }
      ]
    },
  )
  @override
  Future<SingleArticleResponse> createArticleFavorite(
    @PathParam('slug') String slug,
  ) {
    return super.createArticleFavorite(slug).timeout(timeout);
  }

  /// Unfavorite an article
  ///
  /// Unfavorite an article. Auth is required
  @override
  @DeleteReq(
    path: '/articles/:slug/favorite',
    metadata: {
      'auth': [
        {
          'type': 'apiKey',
          'name': 'Token',
          'keyName': 'Authorization',
          'where': 'header'
        }
      ]
    },
  )
  @override
  Future<SingleArticleResponse> deleteArticleFavorite(
    @PathParam('slug') String slug,
  ) {
    return super.deleteArticleFavorite(slug).timeout(timeout);
  }
}
