import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'update_user.jser.dart';

class UpdateUser {
  @Alias('username', isNullable: false)
  final String username;

  @Alias('email', isNullable: false)
  final String email;

  @Alias('token', isNullable: false)
  final String token;

  @Alias('bio', isNullable: false)
  final String bio;

  @Alias('image', isNullable: false)
  final String image;

  UpdateUser({
    this.username,
    this.email,
    this.token,
    this.bio,
    this.image,
  });

  @override
  String toString() {
    return 'UpdateUser[email=$email, token=$token, username=$username, bio=$bio, image=$image, ]';
  }
}

@GenSerializer(nullableFields: true)
class UpdateUserSerializer extends Serializer<UpdateUser>
    with _$UpdateUserSerializer {}
