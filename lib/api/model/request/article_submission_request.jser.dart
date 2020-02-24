// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_submission_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ArticleSubmissionRequestSerializer
    implements Serializer<ArticleSubmissionRequest> {
  Serializer<ArticleSubmission> __articleSubmissionSerializer;

  Serializer<ArticleSubmission> get _articleSubmissionSerializer =>
      __articleSubmissionSerializer ??= ArticleSubmissionSerializer();

  @override
  Map<String, dynamic> toMap(ArticleSubmissionRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'article', _articleSubmissionSerializer.toMap(model.article));
    return ret;
  }

  @override
  ArticleSubmissionRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = ArticleSubmissionRequest(
        article: _articleSubmissionSerializer.fromMap(map['article'] as Map) ??
            getJserDefault('article'));
    return obj;
  }
}
