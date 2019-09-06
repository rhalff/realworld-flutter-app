// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_article_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NewArticleRequestSerializer
    implements Serializer<NewArticleRequest> {
  Serializer<NewArticle> __newArticleSerializer;
  Serializer<NewArticle> get _newArticleSerializer =>
      __newArticleSerializer ??= NewArticleSerializer();
  @override
  Map<String, dynamic> toMap(NewArticleRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'article', _newArticleSerializer.toMap(model.article));
    return ret;
  }

  @override
  NewArticleRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = NewArticleRequest(
        article: _newArticleSerializer.fromMap(map['article'] as Map) ??
            getJserDefault('article'));
    return obj;
  }
}
