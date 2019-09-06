// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$TagsResponseSerializer implements Serializer<TagsResponse> {
  @override
  Map<String, dynamic> toMap(TagsResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'tags',
        codeNonNullIterable(model.tags, (val) => val as String, []));
    return ret;
  }

  @override
  TagsResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = TagsResponse(
        tags: codeNonNullIterable<String>(
                map['tags'] as Iterable, (val) => val as String, <String>[]) ??
            getJserDefault('tags'));
    return obj;
  }
}
