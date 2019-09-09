import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticlesEvent extends Equatable {
  ArticlesEvent([List props = const []]) : super(props);
}

class LoadArticles extends ArticlesEvent {
  final String tag;
  final String author;
  final String favorited;
  final bool refresh;
  LoadArticles({
    this.tag,
    this.author,
    this.favorited,
    this.refresh = false,
  });
  @override
  String toString() =>
      'LoadArticles[tag: $tag, author: $author, favorited: $favorited, refresh: $refresh]';
}

class LoadArticlesFeed extends ArticlesEvent {
  LoadArticlesFeed();
  @override
  String toString() => 'LoadArticlesFeed[]';
}
