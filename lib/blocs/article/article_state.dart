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

class ArticleLoaded extends ArticleState {
  final Article article;
  final List<Comment> comments;

  ArticleLoaded({
    this.article,
    this.comments,
  }) : super([article, comments]);

  @override
  String toString() {
    return 'ArticleLoaded[article: $article, comments: $comments]';
  }
}

class ArticleError extends ArticleState {
  final Object error;

  ArticleError(this.error) : super([error]);

  @override
  String toString() => 'ArticleError[error: $error]';
}
