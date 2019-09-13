import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:validations/validations.dart';

part 'article_submission.g.dart';
part 'article_submission.jser.dart';

class ArticleSubmission {
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
  List<String> tagList;

  ArticleSubmission({
    this.title,
    this.description,
    this.body,
    this.tagList = const [],
  });

  @override
  String toString() {
    return 'ArticleSubmission[title=$title, description=$description, body=$body, tagList=$tagList]';
  }
}

@GenSerializer(nullableFields: true)
class ArticleSubmissionSerializer extends Serializer<ArticleSubmission>
    with _$ArticleSubmissionSerializer {}

@GenValidator()
class ArticleSubmissionValidator extends Validator<ArticleSubmission>
    with _$ArticleSubmissionValidator {}
