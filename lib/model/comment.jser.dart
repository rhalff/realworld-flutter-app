// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$CommentSerializer implements Serializer<Comment> {
  Serializer<Profile> __profileSerializer;

  Serializer<Profile> get _profileSerializer =>
      __profileSerializer ??= ProfileSerializer();

  @override
  Map<String, dynamic> toMap(Comment model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'id', model.id);
    setMapValueIfNotNull(
        ret, 'createdAt', dateTimeUtcProcessor.serialize(model.createdAt));
    setMapValueIfNotNull(
        ret, 'updatedAt', dateTimeUtcProcessor.serialize(model.updatedAt));
    setMapValueIfNotNull(ret, 'body', model.body);
    setMapValueIfNotNull(ret, 'author', _profileSerializer.toMap(model.author));
    return ret;
  }

  @override
  Comment fromMap(Map map) {
    if (map == null) return null;
    final obj = Comment(
        id: map['id'] as int ?? getJserDefault('id'),
        createdAt:
            dateTimeUtcProcessor.deserialize(map['createdAt'] as String) ??
                getJserDefault('createdAt'),
        updatedAt:
            dateTimeUtcProcessor.deserialize(map['updatedAt'] as String) ??
                getJserDefault('updatedAt'),
        body: map['body'] as String ?? getJserDefault('body'),
        author: _profileSerializer.fromMap(map['author'] as Map) ??
            getJserDefault('author'));
    return obj;
  }
}
