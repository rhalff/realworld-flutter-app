// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UpdateUserSerializer implements Serializer<UpdateUser> {
  @override
  Map<String, dynamic> toMap(UpdateUser model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'username', model.username);
    setMapValueIfNotNull(ret, 'email', model.email);
    setMapValueIfNotNull(ret, 'token', model.token);
    setMapValueIfNotNull(ret, 'bio', model.bio);
    setMapValueIfNotNull(ret, 'image', model.image);
    return ret;
  }

  @override
  UpdateUser fromMap(Map map) {
    if (map == null) return null;
    final obj = UpdateUser(
        username: map['username'] as String ?? getJserDefault('username'),
        email: map['email'] as String ?? getJserDefault('email'),
        token: map['token'] as String ?? getJserDefault('token'),
        bio: map['bio'] as String ?? getJserDefault('bio'),
        image: map['image'] as String ?? getJserDefault('image'));
    return obj;
  }
}
