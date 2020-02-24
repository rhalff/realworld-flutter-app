part of blocs.article;

@immutable
abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

@immutable
class LoadArticleEvent extends ArticleEvent {
  final String slug;

  const LoadArticleEvent({
    @required this.slug,
  });

  @override
  String toString() => 'LoadArticleEvent[$slug]';

  @override
  List<Object> get props => [slug];
}

class CreateArticleEvent extends ArticleEvent {
  final ArticleSubmission article;

  CreateArticleEvent({
    this.article,
  });

  @override
  String toString() => 'CreateArticleEvent[article: $article]';

  @override
  List<Object> get props => [article];
}

@immutable
class UpdateArticleEvent extends ArticleEvent {
  final String slug;
  final ArticleSubmission article;
  final Function() onComplete;

  const UpdateArticleEvent({
    @required this.slug,
    @required this.article,
    @required this.onComplete,
  });

  @override
  String toString() => 'UpdateArticleEvent[slug: $slug, article: $article]';

  @override
  List<Object> get props => [slug, article];
}

@immutable
class DeleteArticleEvent extends ArticleEvent {
  final String slug;
  final Function() onComplete;

  const DeleteArticleEvent({
    @required this.slug,
    @required this.onComplete,
  });

  @override
  String toString() => 'DeleteArticleEvent[slug: $slug]';

  @override
  List<Object> get props => [slug];
}

@immutable
class ToggleFavoriteEvent extends ArticleEvent {
  final String slug;

  ToggleFavoriteEvent({
    @required this.slug,
  });

  @override
  String toString() => 'ToggleFavoriteEvent[slug: $slug]';

  @override
  List<Object> get props => [slug];
}
