import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/model/article.dart';

part 'single_article_response.jser.dart';

class SingleArticleResponse {
  @Alias('article', isNullable: false)
  final Article article;

  SingleArticleResponse({
    this.article,
  });

  @override
  String toString() {
    return 'SingleArticleResponse[article=$article, ]';
  }
}

@GenSerializer(nullableFields: true)
class SingleArticleResponseSerializer extends Serializer<SingleArticleResponse>
    with _$SingleArticleResponseSerializer {}
