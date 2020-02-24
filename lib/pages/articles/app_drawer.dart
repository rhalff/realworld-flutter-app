import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/auth/bloc.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/pages/articles/about.dart';
import 'package:realworld_flutter/screens/article_editor.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/screens/profile.dart';
import 'package:realworld_flutter/widgets/user_avatar.dart';

class AppDrawer extends StatelessWidget {
  final User user;

  AppDrawer({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 210,
          child: DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () => _toProfile(context),
                  child: UserAvatar(
                    radius: 36,
                    avatar: user.image,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => _toProfile(context),
                  child: Text(
                    user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(
                    minWidth: 10.0,
                    minHeight: 36.0,
                  ),
                  child: Text(locale.appDrawerViewProfile),
                  onPressed: () => _toProfile(context),
                )
              ],
            ),
          ),
        ),
        ListTile(
          title: Text(locale.appDrawerFavorited),
          onTap: () {
            Navigator.of(context).popAndPushNamed(
              ProfileScreen.route,
              arguments: {
                'username': user.username,
                'feed': 'favorited-posts',
              },
            );
          },
        ),
        const Divider(),
        ListTile(
          title: Text(locale.appDrawerNewArticle),
          onTap: () {
            Navigator.of(context).popAndPushNamed(ArticleEditorScreen.route);
          },
        ),
        ListTile(
          title: Text(locale.appDrawerArticles),
          onTap: () {
            Navigator.of(context).popAndPushNamed(
              ProfileScreen.route,
              arguments: {
                'username': user.username,
                'feed': 'my-posts',
              },
            );
          },
        ),
        const Divider(),
        ListTile(
          title: Text(locale.appDrawerLogout),
          onTap: () => BlocProvider.of<AuthBloc>(context)
            ..add(
              SignOutEvent(
                onComplete: () =>
                    Navigator.of(context).popAndPushNamed(HomeScreen.route),
              ),
            ),
        ),
        ListTile(
          title: Text(locale.appDrawerAbout),
          onTap: () => about(context),
        ),
      ],
    );
  }

  void _toProfile(BuildContext context) {
    Navigator.of(context).popAndPushNamed(
      ProfileScreen.route,
      arguments: {
        'username': user.username,
      },
    );
  }
}
