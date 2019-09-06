// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_comment_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NewCommentRequestSerializer
    implements Serializer<NewCommentRequest> {
  Serializer<NewComment> __newCommentSerializer;
  Serializer<NewComment> get _newCommentSerializer =>
      __newCommentSerializer ??= NewCommentSerializer();
  @override
  Map<String, dynamic> toMap(NewCommentRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'comment', _newCommentSerializer.toMap(model.comment));
    return ret;
  }

  @override
  NewCommentRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = NewCommentRequest(
        comment: _newCommentSerializer.fromMap(map['comment'] as Map) ??
            getJserDefault('comment'));
    return obj;
  }
}
