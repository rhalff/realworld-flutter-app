import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'new_article.jser.dart';

class NewArticle {
  @Alias('title', isNullable: false)
  final String title;

  @Alias('description', isNullable: false)
  final String description;

  @Alias('body', isNullable: false)
  final String body;

  @Alias('tagList', isNullable: false)
  final List<String> tagList;

  NewArticle(
      {this.title = null,
      this.description = null,
      this.body = null,
      this.tagList = const []});

  @override
  String toString() {
    return 'NewArticle[title=$title, description=$description, body=$body, tagList=$tagList, ]';
  }
}

@GenSerializer(nullableFields: true)
class NewArticleSerializer extends Serializer<NewArticle>
    with _$NewArticleSerializer {}
