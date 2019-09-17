import 'package:realworld_flutter/api/articles_api.dart';
import 'package:realworld_flutter/api/comments_api.dart';
import 'package:realworld_flutter/api/favorites_api.dart';
import 'package:realworld_flutter/api/model/article_submission.dart';
import 'package:realworld_flutter/api/model/new_comment.dart';
import 'package:realworld_flutter/api/model/request/article_submission_request.dart';
import 'package:realworld_flutter/api/model/request/new_comment_request.dart';
import 'package:realworld_flutter/api/model/response/multiple_articles_response.dart';
import 'package:realworld_flutter/api/tags_api.dart';
import 'package:realworld_flutter/event_emitter.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/comment.dart';

abstract class ArticleRepositoryEvent {}

class ArticleCreatedEvent extends ArticleRepositoryEvent {
  final Article article;
  ArticleCreatedEvent({this.article});
}

class ArticleUpdatedEvent extends ArticleRepositoryEvent {
  final Article article;
  ArticleUpdatedEvent({this.article});
}

class ArticleDeletedEvent extends ArticleRepositoryEvent {
  final String slug;
  ArticleDeletedEvent({this.slug});
}

class CommentCreatedEvent extends ArticleRepositoryEvent {
  final String slug;
  final Comment comment;
  CommentCreatedEvent({this.slug, this.comment});
}

class CommentDeletedEvent extends ArticleRepositoryEvent {
  final String slug;
  final int id;
  CommentDeletedEvent({this.slug, this.id});
}

class FavoriteCreatedEvent extends ArticleRepositoryEvent {
  final String slug;
  final Article article;
  FavoriteCreatedEvent({this.slug, this.article});
}

class FavoriteDeletedEvent extends ArticleRepositoryEvent {
  final String slug;
  final Article article;
  FavoriteDeletedEvent({this.slug, this.article});
}

class ArticlesRepository extends EventEmitter {
  ArticlesApi articlesApi;
  CommentsApi commentsApi;
  TagsApi tagsApi;
  FavoritesApi favoritesApi;

  ArticlesRepository({
    this.articlesApi,
    this.commentsApi,
    this.favoritesApi,
    this.tagsApi,
  });

  Future<Article> getArticle(String slug) async {
    final result = await articlesApi.getArticle(slug);

    return result.article;
  }

  Future<MultipleArticlesResponse> getArticles({
    String tag,
    String author,
    String favorited,
    int limit,
    int offset,
  }) async {
    final result = await articlesApi.getArticles(
      tag,
      author,
      favorited,
      limit,
      offset,
    );

    return result;
  }

  Future<MultipleArticlesResponse> getArticlesFeed({
    int limit,
    int offset,
  }) async {
    final result = articlesApi.getArticlesFeed(limit, offset);

    return result;
  }

  Future<Article> createArticle(ArticleSubmission article) async {
    final result = await articlesApi.createArticle(
      ArticleSubmissionRequest(article: article),
    );

    fire(ArticleCreatedEvent(article: result.article));

    return result.article;
  }

  Future<Article> updateArticle(String slug, ArticleSubmission article) async {
    final result = await articlesApi.updateArticle(
      slug,
      ArticleSubmissionRequest(article: article),
    );

    fire(ArticleUpdatedEvent(article: result.article));

    return result.article;
  }

  Future<void> deleteArticle(String slug) async {
    await articlesApi.deleteArticle(slug);

    fire(ArticleDeletedEvent(slug: slug));
  }

  Future<List<Comment>> getComments(String slug) async {
    final result = await commentsApi.getArticleComments(slug);

    return result.comments;
  }

  Future<Comment> createComment(
    String slug,
    NewComment comment,
  ) async {
    final result = await commentsApi.createArticleComment(
      slug,
      NewCommentRequest(comment: comment),
    );

    fire(CommentCreatedEvent(slug: slug, comment: result.comment));

    return result.comment;
  }

  Future<void> deleteComment(String slug, int id) async {
    await commentsApi.deleteArticleComment(slug, id);

    fire(CommentDeletedEvent(slug: slug, id: id));
  }

  Future<List<String>> getTags() async {
    final result = await tagsApi.tagsGet();

    return result.tags;
  }

  Future<Article> createFavorite(String slug) async {
    final result = await favoritesApi.createArticleFavorite(slug);

    fire(FavoriteCreatedEvent(slug: slug, article: result.article));

    return result.article;
  }

  Future<Article> deleteArticleFavorite(String slug) async {
    final result = await favoritesApi.deleteArticleFavorite(slug);

    fire(FavoriteDeletedEvent(slug: slug, article: result.article));

    return result.article;
  }
}
