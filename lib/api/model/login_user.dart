import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:validations/validations.dart';

part 'login_user.g.dart';
part 'login_user.jser.dart';

class LoginUser {
  @Alias('email', isNullable: false)
  @Email()
  @NotEmpty()
  String email;

  @Alias('password', isNullable: false)
  @NotEmpty()
  @Size(
    min: 8,
    max: 255,
    message: r'password length must be between $min and $max',
  )
  String password;

  LoginUser({
    this.email,
    this.password,
  });

  @override
  String toString() {
    return 'LoginUser[email=$email, password=$password]';
  }
}

@GenSerializer(nullableFields: true)
class LoginUserSerializer extends Serializer<LoginUser>
    with _$LoginUserSerializer {}

@GenValidator()
class LoginUserValidator extends Validator<LoginUser>
    with _$LoginUserValidator {}
