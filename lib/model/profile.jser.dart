// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ProfileSerializer implements Serializer<Profile> {
  final _sanitizeUrlProcessor = const SanitizeUrlProcessor();
  @override
  Map<String, dynamic> toMap(Profile model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'username', model.username);
    setMapValueIfNotNull(ret, 'bio', model.bio);
    setMapValue(ret, 'image', _sanitizeUrlProcessor.serialize(model.image));
    setMapValueIfNotNull(ret, 'following', model.following);
    return ret;
  }

  @override
  Profile fromMap(Map map) {
    if (map == null) return null;
    final obj = Profile(
        username: map['username'] as String ?? getJserDefault('username'),
        bio: map['bio'] as String ?? getJserDefault('bio'),
        image: _sanitizeUrlProcessor.deserialize(map['image'] as String) ??
            getJserDefault('image'),
        following: map['following'] as bool ?? getJserDefault('following'));
    return obj;
  }
}
