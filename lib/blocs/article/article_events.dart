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
class ToggleFavoriteEvent extends ArticleEvent {
  final String slug;
  ToggleFavoriteEvent({
    this.slug,
  }); // : super([slug]);
  @override
  String toString() => 'ToggleFavoriteEvent[slug: $slug]';
}
