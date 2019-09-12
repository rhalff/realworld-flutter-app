part of blocs.article;

@immutable
abstract class ArticleEvent extends Equatable {
  const ArticleEvent([List props = const []]) : super(props);
}

@immutable
class LoadArticleEvent extends ArticleEvent {
  final String slug;
  const LoadArticleEvent({
    this.slug,
  });
  @override
  String toString() => 'LoadArticleEvent[$slug]';
}

class CreateArticleEvent extends ArticleEvent {
  final NewArticle article;
  CreateArticleEvent({
    this.article,
  });
  @override
  String toString() => 'CreateArticleEvent[article: $article]';
}

@immutable
class UpdateArticleEvent extends ArticleEvent {
  final String slug;
  final UpdateArticle article;
  const UpdateArticleEvent({
    this.slug,
    this.article,
  });
  @override
  String toString() => 'UpdateArticleEvent[slug: $slug, article: $article]';
}

@immutable
class DeleteArticleEvent extends ArticleEvent {
  final String slug;
  const DeleteArticleEvent({
    this.slug,
  });
  @override
  String toString() => 'DeleteArticleEvent[slug: $slug]';
}

@immutable
class CreateCommentEvent extends ArticleEvent {
  final String slug;
  final NewComment comment;
  const CreateCommentEvent({
    this.slug,
    this.comment,
  });
  @override
  String toString() => 'CreateCommentEvent[slug: $slug, comment: $comment]';
}

@immutable
class DeleteCommentEvent extends ArticleEvent {
  final String slug;
  final int id;
  const DeleteCommentEvent({
    this.slug,
    this.id,
  });
  @override
  String toString() => 'DeleteCommentEvent[slug: $slug, id: $id]';
}
