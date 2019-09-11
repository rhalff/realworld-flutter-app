import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:validations/validations.dart';

part 'update_user.g.dart';
part 'update_user.jser.dart';

class UpdateUser {
  @Size(
    min: 2,
    max: 255,
  )
  @Alias('username', isNullable: false)
  String username;

  @Email()
  @NotEmpty()
  @Alias('email', isNullable: false)
  String email;

  @Alias('token', isNullable: false)
  String token;

  @NotEmpty()
  @Size(
    min: 1,
    max: 255,
  )
  @Alias('bio', isNullable: false)
  String bio;

  @Size(
    min: 2,
    max: 255,
  )
  @Alias('image', isNullable: false)
  String image;

  UpdateUser({
    this.username,
    this.email,
    this.token,
    this.bio,
    this.image,
  });

  @override
  String toString() {
    return 'UpdateUser[email=$email, token=$token, username=$username, bio=$bio, image=$image]';
  }
}

@GenSerializer(nullableFields: true)
class UpdateUserSerializer extends Serializer<UpdateUser>
    with _$UpdateUserSerializer {}

@GenValidator()
class UpdateUserValidator extends Validator<UpdateUser>
    with _$UpdateUserValidator {}
