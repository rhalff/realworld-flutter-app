import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/new_article.dart';

part 'new_article_request.jser.dart';

class NewArticleRequest {
  @Alias('article', isNullable: false)
  final NewArticle article;

  NewArticleRequest({
    this.article,
  });

  @override
  String toString() {
    return 'NewArticleRequest[article=$article, ]';
  }
}

@GenSerializer(nullableFields: true)
class NewArticleRequestSerializer extends Serializer<NewArticleRequest>
    with _$NewArticleRequestSerializer {}
