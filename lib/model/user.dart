import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'user.jser.dart';

class User {
  @Alias('email', isNullable: false)
  final String email;

  @Alias('token', isNullable: false)
  final String token;

  @Alias('username', isNullable: false)
  final String username;

  @Alias('bio', isNullable: false)
  final String bio;

  @Alias('image', isNullable: false)
  final String image;

  User(
      {this.email = null,
      this.token = null,
      this.username = null,
      this.bio = null,
      this.image = null});

  @override
  String toString() {
    return 'User[email=$email, token=$token, username=$username, bio=$bio, image=$image, ]';
  }
}

@GenSerializer(nullableFields: true)
class UserSerializer extends Serializer<User> with _$UserSerializer {}
