part of blocs.article;

@immutable
abstract class ArticleState extends Equatable {
  ArticleState([List props = const []]) : super(props);
}

class ArticleUninitialized extends ArticleState {
  @override
  String toString() => 'ArticleUninitialized';
}

class ArticleLoading extends ArticleState {
  @override
  String toString() => 'ArticleLoading';
}

class ArticleSaved extends ArticleState {
  final Article article;
  ArticleSaved({
    this.article,
  });
  @override
  String toString() => 'ArticleSaved(article: $article)';
}

class ArticleLoaded extends ArticleState {
  final Article article;

  ArticleLoaded({
    this.article,
  }) : super([article]);

  @override
  String toString() {
    return 'ArticleLoaded[article: $article]';
  }
}

class ArticleError extends ArticleState {
  final Object error;

  ArticleError(this.error) : super([error]);

  @override
  String toString() => 'ArticleError[error: $error]';
}
