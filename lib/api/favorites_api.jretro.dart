// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$FavoritesApiClient implements ApiClient {
  final String basePath = "";

  Future<SingleArticleResponse> createArticleFavorite(String slug) async {
    var req = base.post
        .metadata({
          "auth": true,
        })
        .path(basePath)
        .path("/articles/:slug/favorite")
        .pathParams("slug", slug);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<SingleArticleResponse> deleteArticleFavorite(String slug) async {
    var req = base.delete
        .metadata({
          "auth": true,
        })
        .path(basePath)
        .path("/articles/:slug/favorite")
        .pathParams("slug", slug);
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
