import 'dart:async';

import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/request/new_comment_request.dart';
import 'package:realworld_flutter/api/model/response/multiple_comments_response.dart';
import 'package:realworld_flutter/api/model/response/single_comment_response.dart';

part 'comments_api.jretro.dart';

@GenApiClient()
class CommentsApi extends ApiClient with _$CommentsApiClient {
  @override
  final Route base;
  @override
  final Map<String, CodecRepo> converters;
  final Duration timeout;

  CommentsApi({
    this.base,
    this.converters,
    this.timeout = const Duration(minutes: 2),
  });

  /// Create a comment for an article
  ///
  /// Create a comment for an article. Auth is required
  @PostReq(path: '/articles/:slug/comments', metadata: {
    'auth': [
      {
        'type': 'apiKey',
        'name': 'Token',
        'keyName': 'Authorization',
        'where': 'header'
      }
    ]
  })
  @override
  Future<SingleCommentResponse> createArticleComment(
    @PathParam('slug') String slug,
    @AsJson() NewCommentRequest comment,
  ) {
    return super.createArticleComment(slug, comment).timeout(timeout);
  }

  /// Delete a comment for an article
  ///
  /// Delete a comment for an article. Auth is required
  @DeleteReq(path: '/articles/:slug/comments/:id', metadata: {
    'auth': [
      {
        'type': 'apiKey',
        'name': 'Token',
        'keyName': 'Authorization',
        'where': 'header'
      }
    ]
  })
  @override
  Future<void> deleteArticleComment(
    @PathParam('slug') String slug,
    @PathParam('id') int id,
  ) {
    return super.deleteArticleComment(slug, id).timeout(timeout);
  }

  /// Get comments for an article
  ///
  /// Get the comments for an article. Auth is optional
  @GetReq(path: '/articles/:slug/comments')
  @override
  Future<MultipleCommentsResponse> getArticleComments(
    @PathParam('slug') String slug,
  ) {
    return super.getArticleComments(slug).timeout(timeout);
  }
}
