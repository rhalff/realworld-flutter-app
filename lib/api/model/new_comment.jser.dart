// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_comment.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NewCommentSerializer implements Serializer<NewComment> {
  @override
  Map<String, dynamic> toMap(NewComment model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'body', model.body);
    return ret;
  }

  @override
  NewComment fromMap(Map map) {
    if (map == null) return null;
    final obj =
        NewComment(body: map['body'] as String ?? getJserDefault('body'));
    return obj;
  }
}
