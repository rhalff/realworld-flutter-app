import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/model/profile.dart';

part 'profile_response.jser.dart';

class ProfileResponse {
  @Alias('profile', isNullable: false)
  final Profile profile;

  ProfileResponse({
    this.profile,
  });

  @override
  String toString() {
    return 'ProfileResponse[profile=$profile, ]';
  }
}

@GenSerializer(nullableFields: true)
class ProfileResponseSerializer extends Serializer<ProfileResponse>
    with _$ProfileResponseSerializer {}
