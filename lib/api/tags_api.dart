import 'dart:async';

import 'package:jaguar_retrofit/annotations/annotations.dart';
import 'package:jaguar_retrofit/jaguar_retrofit.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/response/tags_response.dart';

part 'tags_api.jretro.dart';

@GenApiClient()
class TagsApi extends ApiClient with _$TagsApiClient {
  final Route base;
  final Map<String, CodecRepo> converters;
  final Duration timeout;

  TagsApi({
    this.base,
    this.converters,
    this.timeout = const Duration(minutes: 2),
  });

  /// Get tags
  ///
  /// Get tags. Auth not required
  @GetReq(path: "/tags")
  Future<TagsResponse> tagsGet() {
    return super.tagsGet().timeout(timeout);
  }
}
