part of repositories.articles;

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
