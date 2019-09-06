import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'new_user.jser.dart';

class NewUser {
  @Alias('username', isNullable: false)
  final String username;

  @Alias('email', isNullable: false)
  final String email;

  @Alias('password', isNullable: false)
  final String password;

  NewUser({this.username = null, this.email = null, this.password = null});

  @override
  String toString() {
    return 'NewUser[username=$username, email=$email, password=$password, ]';
  }
}

@GenSerializer(nullableFields: true)
class NewUserSerializer extends Serializer<NewUser> with _$NewUserSerializer {}
