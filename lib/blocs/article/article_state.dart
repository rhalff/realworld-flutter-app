part of blocs.article;

@immutable
abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
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

  const ArticleSaved({
    @required this.article,
  });

  @override
  String toString() => 'ArticleSaved(article: $article)';

  @override
  List<Object> get props => [article];
}

class ArticleLoaded extends ArticleState {
  final Article article;

  const ArticleLoaded({
    @required this.article,
  });

  @override
  String toString() {
    return 'ArticleLoaded[article: $article]';
  }

  @override
  List<Object> get props => [article];
}

class ArticleError extends ArticleState {
  final Object error;

  const ArticleError(this.error);

  @override
  String toString() => 'ArticleError[error: $error]';

  @override
  List<Object> get props => [error];
}
