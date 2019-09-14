import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/widgets/header.dart';
import 'package:realworld_flutter/widgets/user_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  ProfileHeader({
    this.profile,
  });
  @override
  Widget build(BuildContext context) {
    return Header(
      crossAxisAlignment: CrossAxisAlignment.center,
      padding: const EdgeInsets.all(20),
      color: const Color(0XFFF3F3F3),
      child: Column(
        children: <Widget>[
          UserAvatar(
            avatar: profile.image,
            radius: 48,
          ),
          const SizedBox(height: 10),
          Text(
            profile.username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (profile.bio != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                profile.bio,
                textAlign: TextAlign.center,
              ),
            )
        ],
      ),
    );
  }
}
