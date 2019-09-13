import 'package:jaguar_serializer/jaguar_serializer.dart';

import '../article_submission.dart';

part 'article_submission_request.jser.dart';

class ArticleSubmissionRequest {
  @Alias('article', isNullable: false)
  final ArticleSubmission article;

  ArticleSubmissionRequest({
    this.article,
  });

  @override
  String toString() {
    return 'ArticleSubmissionRequest[article=$article, ]';
  }
}

@GenSerializer(nullableFields: true)
class ArticleSubmissionRequestSerializer
    extends Serializer<ArticleSubmissionRequest>
    with _$ArticleSubmissionRequestSerializer {}
