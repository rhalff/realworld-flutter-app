import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'package:realworld_flutter/model/update_user.dart';

part 'update_user_request.jser.dart';

class UpdateUserRequest {
  @Alias('user', isNullable: false)
  final UpdateUser user;

  UpdateUserRequest({this.user = null});

  @override
  String toString() {
    return 'UpdateUserRequest[user=$user, ]';
  }
}

@GenSerializer(nullableFields: true)
class UpdateUserRequestSerializer extends Serializer<UpdateUserRequest>
    with _$UpdateUserRequestSerializer {}
