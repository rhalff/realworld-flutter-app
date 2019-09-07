import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/model/article.dart';

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
  final List<Article> articles;
  final bool hasReachedMax;

  ArticlesLoaded(
    this.articles,
    this.hasReachedMax,
  ) : super([articles, hasReachedMax]);

  ArticlesLoaded copyWith({
    List<Article> articles,
    bool hasReachedMax,
  }) {
    return ArticlesLoaded(
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
