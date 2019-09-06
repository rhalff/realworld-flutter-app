// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_article.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NewArticleSerializer implements Serializer<NewArticle> {
  @override
  Map<String, dynamic> toMap(NewArticle model) {
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
  NewArticle fromMap(Map map) {
    if (map == null) return null;
    final obj = NewArticle(
        title: map['title'] as String ?? getJserDefault('title'),
        description:
            map['description'] as String ?? getJserDefault('description'),
        body: map['body'] as String ?? getJserDefault('body'),
        tagList: codeNonNullIterable<String>(map['tagList'] as Iterable,
                (val) => val as String, <String>[]) ??
            getJserDefault('tagList'));
    return obj;
  }
}
