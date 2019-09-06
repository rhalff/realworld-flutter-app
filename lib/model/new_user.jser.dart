// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NewUserSerializer implements Serializer<NewUser> {
  @override
  Map<String, dynamic> toMap(NewUser model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'username', model.username);
    setMapValueIfNotNull(ret, 'email', model.email);
    setMapValueIfNotNull(ret, 'password', model.password);
    return ret;
  }

  @override
  NewUser fromMap(Map map) {
    if (map == null) return null;
    final obj = NewUser(
        username: map['username'] as String ?? getJserDefault('username'),
        email: map['email'] as String ?? getJserDefault('email'),
        password: map['password'] as String ?? getJserDefault('password'));
    return obj;
  }
}
