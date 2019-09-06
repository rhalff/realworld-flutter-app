import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'package:realworld_flutter/model/profile.dart';

part 'comment.jser.dart';

class Comment {
  @Alias('id', isNullable: false)
  final int id;

  @Alias('createdAt', isNullable: false)
  final DateTime createdAt;

  @Alias('updatedAt', isNullable: false)
  final DateTime updatedAt;

  @Alias('body', isNullable: false)
  final String body;

  @Alias('author', isNullable: false)
  final Profile author;

  Comment(
      {this.id = null,
      this.createdAt = null,
      this.updatedAt = null,
      this.body = null,
      this.author = null});

  @override
  String toString() {
    return 'Comment[id=$id, createdAt=$createdAt, updatedAt=$updatedAt, body=$body, author=$author, ]';
  }
}

@GenSerializer(nullableFields: true)
class CommentSerializer extends Serializer<Comment> with _$CommentSerializer {}
