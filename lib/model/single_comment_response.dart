import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'package:realworld_flutter/model/comment.dart';

part 'single_comment_response.jser.dart';

class SingleCommentResponse {
  @Alias('comment', isNullable: false)
  final Comment comment;

  SingleCommentResponse({this.comment = null});

  @override
  String toString() {
    return 'SingleCommentResponse[comment=$comment, ]';
  }
}

@GenSerializer(nullableFields: true)
class SingleCommentResponseSerializer extends Serializer<SingleCommentResponse>
    with _$SingleCommentResponseSerializer {}
