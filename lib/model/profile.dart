import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'profile.jser.dart';

class Profile {
  @Alias('username', isNullable: false)
  final String username;

  @Alias('bio', isNullable: false)
  final String bio;

  @Alias('image', isNullable: false)
  final String image;

  @Alias('following', isNullable: false)
  final bool following;

  Profile(
      {this.username = null,
      this.bio = null,
      this.image = null,
      this.following = null});

  @override
  String toString() {
    return 'Profile[username=$username, bio=$bio, image=$image, following=$following, ]';
  }
}

@GenSerializer(nullableFields: true)
class ProfileSerializer extends Serializer<Profile> with _$ProfileSerializer {}
