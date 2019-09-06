import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/login_user.dart';

part 'login_user_request.jser.dart';

class LoginUserRequest {
  @Alias('user', isNullable: false)
  final LoginUser user;

  LoginUserRequest({
    this.user,
  });

  @override
  String toString() {
    return 'LoginUserRequest[user=$user, ]';
  }
}

@GenSerializer(nullableFields: true)
class LoginUserRequestSerializer extends Serializer<LoginUserRequest>
    with _$LoginUserRequestSerializer {}
