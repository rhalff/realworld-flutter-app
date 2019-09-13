// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$ArticlesApiClient implements ApiClient {
  final String basePath = "";
  Future<SingleArticleResponse> createArticle(
      ArticleSubmissionRequest article) async {
    var req = base.post
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/articles")
        .json(jsonConverter.to(article));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<void> deleteArticle(String slug) async {
    var req = base.delete
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/articles/:slug")
        .pathParams("slug", slug);
    await req.go(throwOnErr: true);
  }

  Future<SingleArticleResponse> getArticle(String slug) async {
    var req = base.get
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/articles/:slug")
        .pathParams("slug", slug);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<MultipleArticlesResponse> getArticles(String tag, String author,
      String favorited, int limit, int offset) async {
    var req = base.get
        .path(basePath)
        .path("/articles")
        .query("tag", tag)
        .query("author", author)
        .query("favorited", favorited)
        .query("limit", limit)
        .query("offset", offset);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<MultipleArticlesResponse> getArticlesFeed(
      int limit, int offset) async {
    var req = base.get
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/articles/feed")
        .query("limit", limit)
        .query("offset", offset);
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<SingleArticleResponse> updateArticle(
      String slug, ArticleSubmissionRequest article) async {
    var req = base.put
        .metadata({
          "auth": [
            {
              "type": "apiKey",
              "name": "Token",
              "keyName": "Authorization",
              "where": "header",
            }
          ],
        })
        .path(basePath)
        .path("/articles/:slug")
        .pathParams("slug", slug)
        .json(jsonConverter.to(article));
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
