import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'update_article.jser.dart';

class UpdateArticle {
  @Alias('title', isNullable: false)
  final String title;

  @Alias('description', isNullable: false)
  final String description;

  @Alias('body', isNullable: false)
  final String body;

  UpdateArticle({
    this.title,
    this.description,
    this.body,
  });

  @override
  String toString() {
    return 'UpdateArticle[title=$title, description=$description, body=$body, ]';
  }
}

@GenSerializer(nullableFields: true)
class UpdateArticleSerializer extends Serializer<UpdateArticle>
    with _$UpdateArticleSerializer {}
