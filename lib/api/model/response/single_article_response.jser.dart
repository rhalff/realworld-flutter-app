// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_article_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$SingleArticleResponseSerializer
    implements Serializer<SingleArticleResponse> {
  Serializer<Article> __articleSerializer;

  Serializer<Article> get _articleSerializer =>
      __articleSerializer ??= ArticleSerializer();

  @override
  Map<String, dynamic> toMap(SingleArticleResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'article', _articleSerializer.toMap(model.article));
    return ret;
  }

  @override
  SingleArticleResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = SingleArticleResponse(
        article: _articleSerializer.fromMap(map['article'] as Map) ??
            getJserDefault('article'));
    return obj;
  }
}
