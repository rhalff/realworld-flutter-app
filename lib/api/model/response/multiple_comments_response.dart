import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/model/comment.dart';

part 'multiple_comments_response.jser.dart';

class MultipleCommentsResponse {
  @Alias('comments', isNullable: false)
  final List<Comment> comments;

  MultipleCommentsResponse({this.comments = const []});

  @override
  String toString() {
    return 'MultipleCommentsResponse[comments=$comments, ]';
  }
}

@GenSerializer(nullableFields: true)
class MultipleCommentsResponseSerializer
    extends Serializer<MultipleCommentsResponse>
    with _$MultipleCommentsResponseSerializer {}
