// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UserSerializer implements Serializer<User> {
  @override
  Map<String, dynamic> toMap(User model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'email', model.email);
    setMapValueIfNotNull(ret, 'username', model.username);
    setMapValueIfNotNull(ret, 'bio', model.bio);
    setMapValueIfNotNull(ret, 'image', model.image);
    setMapValueIfNotNull(ret, 'token', model.token);
    return ret;
  }

  @override
  User fromMap(Map map) {
    if (map == null) return null;
    final obj = User(
        email: map['email'] as String ?? getJserDefault('email'),
        username: map['username'] as String ?? getJserDefault('username'),
        bio: map['bio'] as String ?? getJserDefault('bio'),
        image: map['image'] as String ?? getJserDefault('image'),
        token: map['token'] as String ?? getJserDefault('token'));
    return obj;
  }
}
