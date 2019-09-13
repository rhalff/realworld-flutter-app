import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:validations/validations.dart';

part 'new_article.g.dart';
part 'new_article.jser.dart';

class NewArticle {
  @Alias('title', isNullable: false)
  @Size(
    min: 2,
    max: 255,
  )
  String title;

  @Alias('description', isNullable: false)
  @NotEmpty()
  @Size(
    min: 1,
    max: 500,
  )
  String description;

  @Alias('body', isNullable: false)
  @NotEmpty()
  String body;

  @Alias('tagList', isNullable: false)
  @NotEmpty()
  List<String> tagList;

  NewArticle({
    this.title,
    this.description,
    this.body,
    this.tagList = const [],
  });

  @override
  String toString() {
    return 'NewArticle[title=$title, description=$description, body=$body, tagList=$tagList]';
  }
}

@GenSerializer(nullableFields: true)
class NewArticleSerializer extends Serializer<NewArticle>
    with _$NewArticleSerializer {}

@GenValidator()
class NewArticleValidator extends Validator<NewArticle>
    with _$NewArticleValidator {}
