import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'tags_response.jser.dart';

class TagsResponse {
  @Alias('tags', isNullable: false)
  final List<String> tags;

  TagsResponse({this.tags = const []});

  @override
  String toString() {
    return 'TagsResponse[tags=$tags, ]';
  }
}

@GenSerializer(nullableFields: true)
class TagsResponseSerializer extends Serializer<TagsResponse>
    with _$TagsResponseSerializer {}
