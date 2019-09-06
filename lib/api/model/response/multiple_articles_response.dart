import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/model/article.dart';

part 'multiple_articles_response.jser.dart';

class MultipleArticlesResponse {
  @Alias('articles', isNullable: false)
  final List<Article> articles;

  @Alias('articlesCount', isNullable: false)
  final int articlesCount;

  MultipleArticlesResponse({
    this.articles = const [],
    this.articlesCount,
  });

  @override
  String toString() {
    return 'MultipleArticlesResponse[articles=$articles, articlesCount=$articlesCount, ]';
  }
}

@GenSerializer(nullableFields: true)
class MultipleArticlesResponseSerializer
    extends Serializer<MultipleArticlesResponse>
    with _$MultipleArticlesResponseSerializer {}
