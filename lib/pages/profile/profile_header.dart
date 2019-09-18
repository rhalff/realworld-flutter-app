import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/profile.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/widgets/drop_down_menu.dart';
import 'package:realworld_flutter/widgets/header.dart';
import 'package:realworld_flutter/widgets/user_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  final BoxFit fit;
  final bool isUserPage;
  ProfileHeader({
    this.profile,
    this.fit,
    this.isUserPage,
  });
  @override
  Widget build(BuildContext context) {
    final contentWidth = MediaQuery.of(context).size.width;

    return Header(
      crossAxisAlignment: CrossAxisAlignment.center,
      color: const Color(0XFFF3F3F3),
      fit: fit,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            width: contentWidth,
            child: Column(
              children: <Widget>[
                UserAvatar(
                  avatar: profile.image,
                  radius: 48,
                ),
                const SizedBox(height: 10),
                Text(
                  profile.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (profile.bio != null)
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          profile.bio,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          if (isUserPage)
            Positioned(
              top: 10,
              right: 10,
              child: DropdownMenu(
                onSelect: (item) {
                  if (item.id == 'edit_profile') {
                    Navigator.of(context).pushNamed(SettingsScreen.route);
                  }
                },
                items: [
                  MenuItem(
                    id: 'edit_profile',
                    label: 'Edit profile',
                    icon: Icons.edit,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
