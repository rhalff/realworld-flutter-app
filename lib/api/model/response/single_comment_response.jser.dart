// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_comment_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$SingleCommentResponseSerializer
    implements Serializer<SingleCommentResponse> {
  Serializer<Comment> __commentSerializer;

  Serializer<Comment> get _commentSerializer =>
      __commentSerializer ??= CommentSerializer();

  @override
  Map<String, dynamic> toMap(SingleCommentResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'comment', _commentSerializer.toMap(model.comment));
    return ret;
  }

  @override
  SingleCommentResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = SingleCommentResponse(
        comment: _commentSerializer.fromMap(map['comment'] as Map) ??
            getJserDefault('comment'));
    return obj;
  }
}
