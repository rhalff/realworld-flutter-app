part of blocs.articles;

enum FeedType {
  globalFeed,
  userFeed,
}

@immutable
abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesUninitialized extends ArticlesState {
  @override
  String toString() => 'ArticlesUninitialized';
}

class ArticlesLoading extends ArticlesState {
  @override
  String toString() => 'ArticlesLoading';
}

class ArticlesLoaded extends ArticlesState {
  final FeedType feedType;
  final List<Article> articles;
  final bool hasReachedMax;

  ArticlesLoaded(
    this.feedType,
    this.articles,
    this.hasReachedMax,
  );

  ArticlesLoaded copyWith({
    FeedType feedType,
    List<Article> articles,
    bool hasReachedMax,
  }) {
    return ArticlesLoaded(
      feedType ?? this.feedType,
      articles ?? this.articles,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'ArticlesLoaded[articles: $articles]';
  }

  @override
  List<Object> get props => [feedType, articles, hasReachedMax];
}

class ArticlesError extends ArticlesState {
  final String error;

  ArticlesError(this.error);

  @override
  String toString() => 'ArticlesError[error: $error]';

  @override
  List<Object> get props => [error];
}
