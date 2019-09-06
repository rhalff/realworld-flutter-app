// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_article.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UpdateArticleSerializer implements Serializer<UpdateArticle> {
  @override
  Map<String, dynamic> toMap(UpdateArticle model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'title', model.title);
    setMapValueIfNotNull(ret, 'description', model.description);
    setMapValueIfNotNull(ret, 'body', model.body);
    return ret;
  }

  @override
  UpdateArticle fromMap(Map map) {
    if (map == null) return null;
    final obj = UpdateArticle(
        title: map['title'] as String ?? getJserDefault('title'),
        description:
            map['description'] as String ?? getJserDefault('description'),
        body: map['body'] as String ?? getJserDefault('body'));
    return obj;
  }
}
