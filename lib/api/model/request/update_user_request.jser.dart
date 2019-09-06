// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$UpdateUserRequestSerializer
    implements Serializer<UpdateUserRequest> {
  Serializer<UpdateUser> __updateUserSerializer;
  Serializer<UpdateUser> get _updateUserSerializer =>
      __updateUserSerializer ??= UpdateUserSerializer();
  @override
  Map<String, dynamic> toMap(UpdateUserRequest model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(ret, 'user', _updateUserSerializer.toMap(model.user));
    return ret;
  }

  @override
  UpdateUserRequest fromMap(Map map) {
    if (map == null) return null;
    final obj = UpdateUserRequest(
        user: _updateUserSerializer.fromMap(map['user'] as Map) ??
            getJserDefault('user'));
    return obj;
  }
}
