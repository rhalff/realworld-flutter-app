// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_submission.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ArticleSubmissionSerializer
    implements Serializer<ArticleSubmission> {
  @override
  Map<String, dynamic> toMap(ArticleSubmission model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'title', model.title);
    setMapValueIfNotNull(ret, 'description', model.description);
    setMapValueIfNotNull(ret, 'body', model.body);
    setMapValueIfNotNull(ret, 'tagList',
        codeNonNullIterable(model.tagList, (val) => val as String, []));
    return ret;
  }

  @override
  ArticleSubmission fromMap(Map map) {
    if (map == null) return null;
    final obj = ArticleSubmission();
    obj.title = map['title'] as String ?? getJserDefault('title') ?? obj.title;
    obj.description = map['description'] as String ??
        getJserDefault('description') ??
        obj.description;
    obj.body = map['body'] as String ?? getJserDefault('body') ?? obj.body;
    obj.tagList = codeNonNullIterable<String>(
            map['tagList'] as Iterable, (val) => val as String, <String>[]) ??
        getJserDefault('tagList') ??
        obj.tagList;
    return obj;
  }
}
