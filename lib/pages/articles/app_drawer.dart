import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/screens/article_editor.dart';
import 'package:realworld_flutter/screens/profile.dart';
import 'package:realworld_flutter/widgets/user_avatar.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  AppDrawer({
    @required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 210,
          child: DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UserAvatar(
                  radius: 36,
                  avatar: user.image,
                ),
                const SizedBox(height: 12),
                Text(
                  user.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(
                    minWidth: 10.0,
                    minHeight: 36.0,
                  ),
                  child: const Text('View Profile'),
                  onPressed: () => Navigator.of(context).popAndPushNamed(
                    ProfileScreen.route,
                    arguments: {
                      'username': user.username,
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Favorited'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('New Article'),
          onTap: () {
            Navigator.of(context).popAndPushNamed(ArticleEditorScreen.route);
          },
        ),
        ListTile(
          title: const Text('Articles'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
