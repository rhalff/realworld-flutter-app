// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$NewUserRequestSerializer
    implements Serializer<NewUserRequest> {
  Serializer<NewUser> __newUserSerializer;
  Serializer<NewUser> get _newUserSerializer =>
      __newUserSerializer ??= NewUserSerializer();
  @override
  Map<String, dynamic> toMap(NewUserRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'user', _newUserSerializer.toMap(model.user));
    return ret;
  }

  @override
  NewUserRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = NewUserRequest(
        user: _newUserSerializer.fromMap(map['user'] as Map) ??
            getJserDefault('user'));
    return obj;
  }
}
