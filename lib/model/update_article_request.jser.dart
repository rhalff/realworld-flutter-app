// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_article_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UpdateArticleRequestSerializer
    implements Serializer<UpdateArticleRequest> {
  Serializer<UpdateArticle> __updateArticleSerializer;
  Serializer<UpdateArticle> get _updateArticleSerializer =>
      __updateArticleSerializer ??= UpdateArticleSerializer();
  @override
  Map<String, dynamic> toMap(UpdateArticleRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'article', _updateArticleSerializer.toMap(model.article));
    return ret;
  }

  @override
  UpdateArticleRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = UpdateArticleRequest(
        article: _updateArticleSerializer.fromMap(map['article'] as Map) ??
            getJserDefault('article'));
    return obj;
  }
}
