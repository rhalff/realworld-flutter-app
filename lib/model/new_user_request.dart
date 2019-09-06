import 'package:jaguar_serializer/jaguar_serializer.dart';

import 'package:realworld_flutter/model/new_user.dart';

part 'new_user_request.jser.dart';

class NewUserRequest {
  @Alias('user', isNullable: false)
  final NewUser user;

  NewUserRequest({this.user = null});

  @override
  String toString() {
    return 'NewUserRequest[user=$user, ]';
  }
}

@GenSerializer(nullableFields: true)
class NewUserRequestSerializer extends Serializer<NewUserRequest>
    with _$NewUserRequestSerializer {}
