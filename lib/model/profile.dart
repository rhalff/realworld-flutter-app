import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/model/processors/sanitize_url_processor.dart';

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

  Profile({
    this.username,
    this.bio,
    this.image,
    this.following,
  });

  @override
  String toString() {
    return 'Profile[username=$username, bio=$bio, image=$image, following=$following, ]';
  }
}

@GenSerializer(nullableFields: true, fields: {
  'image': Field(
    processor: SanitizeUrlProcessor(),
  ),
})
class ProfileSerializer extends Serializer<Profile> with _$ProfileSerializer {}
