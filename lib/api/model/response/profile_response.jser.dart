// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$ProfileResponseSerializer
    implements Serializer<ProfileResponse> {
  Serializer<Profile> __profileSerializer;

  Serializer<Profile> get _profileSerializer =>
      __profileSerializer ??= ProfileSerializer();

  @override
  Map<String, dynamic> toMap(ProfileResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'profile', _profileSerializer.toMap(model.profile));
    return ret;
  }

  @override
  ProfileResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = ProfileResponse(
        profile: _profileSerializer.fromMap(map['profile'] as Map) ??
            getJserDefault('profile'));
    return obj;
  }
}
