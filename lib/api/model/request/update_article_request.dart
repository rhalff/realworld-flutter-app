import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/update_article.dart';

part 'update_article_request.jser.dart';

class UpdateArticleRequest {
  @Alias('article', isNullable: false)
  final UpdateArticle article;

  UpdateArticleRequest({
    this.article,
  });

  @override
  String toString() {
    return 'UpdateArticleRequest[article=$article]';
  }
}

@GenSerializer(nullableFields: true)
class UpdateArticleRequestSerializer extends Serializer<UpdateArticleRequest>
    with _$UpdateArticleRequestSerializer {}
