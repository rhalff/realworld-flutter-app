// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UserResponseSerializer implements Serializer<UserResponse> {
  Serializer<User> __userSerializer;
  Serializer<User> get _userSerializer => __userSerializer ??= UserSerializer();
  @override
  Map<String, dynamic> toMap(UserResponse model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'user', _userSerializer.toMap(model.user));
    return ret;
  }

  @override
  UserResponse fromMap(Map map) {
    if (map == null) return null;
    final obj = UserResponse(
        user: _userSerializer.fromMap(map['user'] as Map) ??
            getJserDefault('user'));
    return obj;
  }
}
