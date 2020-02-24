// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_articles_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$MultipleArticlesResponseSerializer
    implements Serializer<MultipleArticlesResponse> {
  Serializer<Article> __articleSerializer;

  Serializer<Article> get _articleSerializer =>
      __articleSerializer ??= ArticleSerializer();

  @override
  Map<String, dynamic> toMap(MultipleArticlesResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret,
        'articles',
        codeNonNullIterable(model.articles,
            (val) => _articleSerializer.toMap(val as Article), []));
    setMapValueIfNotNull(ret, 'articlesCount', model.articlesCount);
    return ret;
  }

  @override
  MultipleArticlesResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = MultipleArticlesResponse(
        articles: codeNonNullIterable<Article>(map['articles'] as Iterable,
                (val) => _articleSerializer.fromMap(val as Map), <Article>[]) ??
            getJserDefault('articles'),
        articlesCount:
            map['articlesCount'] as int ?? getJserDefault('articlesCount'));
    return obj;
  }
}
