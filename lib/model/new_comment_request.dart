import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'package:realworld_flutter/model/new_comment.dart';

part 'new_comment_request.jser.dart';

class NewCommentRequest {
  @Alias('comment', isNullable: false)
  final NewComment comment;

  NewCommentRequest({this.comment = null});

  @override
  String toString() {
    return 'NewCommentRequest[comment=$comment, ]';
  }
}

@GenSerializer(nullableFields: true)
class NewCommentRequestSerializer extends Serializer<NewCommentRequest>
    with _$NewCommentRequestSerializer {}
