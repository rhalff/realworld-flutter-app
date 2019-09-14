import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:validations/validations.dart';

part 'new_user.g.dart';
part 'new_user.jser.dart';

class NewUser {
  @Alias('username', isNullable: false)
  @Size(
    min: 2,
    max: 255,
  )
  String username;

  @Alias('email', isNullable: false)
  @Email()
  @NotEmpty()
  String email;

  @Alias('password', isNullable: false)
  @NotEmpty()
  @Size(
    min: 2,
    max: 20,
    message: r'password length must be between $min and $max',
  )
  String password;

  NewUser({
    this.username,
    this.email,
    this.password,
  });

  @override
  String toString() {
    return 'NewUser[username=$username, email=$email, password=$password]';
  }
}

@GenSerializer(nullableFields: true)
class NewUserSerializer extends Serializer<NewUser> with _$NewUserSerializer {}

@GenValidator()
class NewUserValidator extends Validator<NewUser> with _$NewUserValidator {}
