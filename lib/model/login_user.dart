import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'login_user.jser.dart';

class LoginUser {
  @Alias('email', isNullable: false)
  final String email;

  @Alias('password', isNullable: false)
  final String password;

  LoginUser({this.email = null, this.password = null});

  @override
  String toString() {
    return 'LoginUser[email=$email, password=$password, ]';
  }
}

@GenSerializer(nullableFields: true)
class LoginUserSerializer extends Serializer<LoginUser>
    with _$LoginUserSerializer {}
