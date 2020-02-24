// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ArticleSerializer implements Serializer<Article> {
  Serializer<Profile> __profileSerializer;

  Serializer<Profile> get _profileSerializer =>
      __profileSerializer ??= ProfileSerializer();

  @override
  Map<String, dynamic> toMap(Article model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'slug', model.slug);
    setMapValueIfNotNull(ret, 'title', model.title);
    setMapValueIfNotNull(ret, 'description', model.description);
    setMapValueIfNotNull(ret, 'body', model.body);
    setMapValueIfNotNull(ret, 'tagList',
        codeNonNullIterable(model.tagList, (val) => val as String, []));
    setMapValueIfNotNull(
        ret, 'createdAt', dateTimeUtcProcessor.serialize(model.createdAt));
    setMapValueIfNotNull(
        ret, 'updatedAt', dateTimeUtcProcessor.serialize(model.updatedAt));
    setMapValueIfNotNull(ret, 'favorited', model.favorited);
    setMapValueIfNotNull(ret, 'favoritesCount', model.favoritesCount);
    setMapValueIfNotNull(ret, 'author', _profileSerializer.toMap(model.author));
    return ret;
  }

  @override
  Article fromMap(Map map) {
    if (map == null) return null;
    final obj = Article(
        slug: map['slug'] as String ?? getJserDefault('slug'),
        title: map['title'] as String ?? getJserDefault('title'),
        description:
            map['description'] as String ?? getJserDefault('description'),
        body: map['body'] as String ?? getJserDefault('body'),
        tagList: codeNonNullIterable<String>(map['tagList'] as Iterable,
                (val) => val as String, <String>[]) ??
            getJserDefault('tagList'),
        createdAt:
            dateTimeUtcProcessor.deserialize(map['createdAt'] as String) ??
                getJserDefault('createdAt'),
        updatedAt:
            dateTimeUtcProcessor.deserialize(map['updatedAt'] as String) ??
                getJserDefault('updatedAt'),
        favorited: map['favorited'] as bool ?? getJserDefault('favorited'),
        favoritesCount:
            map['favoritesCount'] as int ?? getJserDefault('favoritesCount'),
        author: _profileSerializer.fromMap(map['author'] as Map) ??
            getJserDefault('author'));
    return obj;
  }
}
