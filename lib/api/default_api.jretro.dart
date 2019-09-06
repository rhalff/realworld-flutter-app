// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_api.dart';

// **************************************************************************
// JaguarHttpGenerator
// **************************************************************************

abstract class _$DefaultApiClient implements ApiClient {
  final String basePath = "";
  Future<TagsResponse> tagsGet() async {
    var req = base.get.path(basePath).path("/tags");
    return req.go(throwOnErr: true).map(decodeOne);
  }
}
