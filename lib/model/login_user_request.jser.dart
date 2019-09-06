// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$LoginUserRequestSerializer
    implements Serializer<LoginUserRequest> {
  Serializer<LoginUser> __loginUserSerializer;
  Serializer<LoginUser> get _loginUserSerializer =>
      __loginUserSerializer ??= LoginUserSerializer();
  @override
  Map<String, dynamic> toMap(LoginUserRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'user', _loginUserSerializer.toMap(model.user));
    return ret;
  }

  @override
  LoginUserRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = LoginUserRequest(
        user: _loginUserSerializer.fromMap(map['user'] as Map) ??
            getJserDefault('user'));
    return obj;
  }
}
