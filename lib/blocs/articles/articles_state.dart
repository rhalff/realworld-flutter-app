import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/model/article.dart';

enum FeedType {
  globalFeed,
  userFeed,
}

@immutable
abstract class ArticlesState extends Equatable {
  ArticlesState([List props = const []]) : super(props);
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
  ) : super([feedType, articles, hasReachedMax]);

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
}

class ArticlesError extends ArticlesState {
  final String error;

  ArticlesError(this.error) : super([error]);

  @override
  String toString() => 'ArticlesError[error: $error]';
}
