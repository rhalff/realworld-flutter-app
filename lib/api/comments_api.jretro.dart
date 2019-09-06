// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$CommentsApiClient implements ApiClient {
  final String basePath = "";
  Future<SingleCommentResponse> createArticleComment(
      String slug, NewCommentRequest comment) async {
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
        .path("/articles/:slug/comments")
        .pathParams("slug", slug)
        .json(jsonConverter.to(comment));
    return req.go(throwOnErr: true).map(decodeOne);
  }

  Future<void> deleteArticleComment(String slug, int id) async {
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
        .path("/articles/:slug/comments/:id")
        .pathParams("slug", slug)
        .pathParams("id", id);
    await req.go(throwOnErr: true);
  }

  Future<MultipleCommentsResponse> getArticleComments(String slug) async {
    var req = base.get
        .path(basePath)
        .path("/articles/:slug/comments")
        .pathParams("slug", slug);
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
