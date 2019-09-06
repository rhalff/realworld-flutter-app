// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_comments_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$MultipleCommentsResponseSerializer
    implements Serializer<MultipleCommentsResponse> {
  Serializer<Comment> __commentSerializer;
  Serializer<Comment> get _commentSerializer =>
      __commentSerializer ??= CommentSerializer();
  @override
  Map<String, dynamic> toMap(MultipleCommentsResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret,
        'comments',
        codeNonNullIterable(model.comments,
            (val) => _commentSerializer.toMap(val as Comment), []));
    return ret;
  }

  @override
  MultipleCommentsResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = MultipleCommentsResponse(
        comments: codeNonNullIterable<Comment>(map['comments'] as Iterable,
                (val) => _commentSerializer.fromMap(val as Map), <Comment>[]) ??
            getJserDefault('comments'));
    return obj;
  }
}
