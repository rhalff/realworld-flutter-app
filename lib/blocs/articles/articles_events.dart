part of blocs.articles;

abstract class ArticlesEvent {}

@immutable
class LoadArticlesEvent extends ArticlesEvent {
  final String tag;
  final String author;
  final String favorited;
  final bool refresh;
  LoadArticlesEvent({
    this.tag,
    this.author,
    this.favorited,
    this.refresh = false,
  }); // : super([tag, author, favorited, refresh]);
  @override
  String toString() =>
      'LoadArticles[tag: $tag, author: $author, favorited: $favorited, refresh: $refresh]';
}

@immutable
class UpdateArticleInListEvent extends ArticlesEvent {
  final Article article;
  UpdateArticleInListEvent({
    this.article,
  });
  @override
  String toString() => 'UpdateArticleInListEvent[article: $article]';
}

@immutable
class ReloadArticlesEvent extends ArticlesEvent {}

@immutable
class LoadArticlesFeedEvent extends ArticlesEvent {
  final bool refresh;
  LoadArticlesFeedEvent({
    this.refresh = false,
  }); // : super([refresh]);
  @override
  String toString() => 'LoadArticlesFeedEvent[refresh: $refresh]';
}

@immutable
class ToggleFavoriteEvent extends ArticlesEvent {
  final String slug;
  ToggleFavoriteEvent({
    @required this.slug,
  }); // : super([slug]);
  @override
  String toString() => 'ToggleFavoriteEvent[slug: $slug]';
}
