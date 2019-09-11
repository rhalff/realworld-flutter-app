import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'new_comment.jser.dart';

class NewComment {
  @Alias('body', isNullable: false)
  final String body;

  NewComment({
    this.body,
  });

  @override
  String toString() {
    return 'NewComment[body=$body]';
  }
}

@GenSerializer(nullableFields: true)
class NewCommentSerializer extends Serializer<NewComment>
    with _$NewCommentSerializer {}
