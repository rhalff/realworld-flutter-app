// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$LoginUserSerializer implements Serializer<LoginUser> {
  @override
  Map<String, dynamic> toMap(LoginUser model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'email', model.email);
    setMapValueIfNotNull(ret, 'password', model.password);
    return ret;
  }

  @override
  LoginUser fromMap(Map map) {
    if (map == null) return null;
    final obj = LoginUser();
    obj.email = map['email'] as String ?? getJserDefault('email') ?? obj.email;
    obj.password =
        map['password'] as String ?? getJserDefault('password') ?? obj.password;
    return obj;
  }
}
