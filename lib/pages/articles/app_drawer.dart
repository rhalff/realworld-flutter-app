import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/screens/article_editor.dart';
import 'package:realworld_flutter/screens/profile.dart';
import 'package:realworld_flutter/widgets/user_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  child: const Text('View Profile'),
                  onPressed: () => _toProfile(context),
                )
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('Favorited'),
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
          title: const Text('New Article'),
          onTap: () {
            Navigator.of(context).popAndPushNamed(ArticleEditorScreen.route);
          },
        ),
        ListTile(
          title: const Text('Articles'),
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
          title: const Text('About'),
          onTap: () => _about(context),
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

  void _about(BuildContext context) {
    final themeData = Theme.of(context);
    final aboutTextStyle = themeData.textTheme.body2;
    final linkStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);

    showAboutDialog(
      context: context,
      applicationName: 'RealWorld Flutter',
      /*
      applicationIcon: Image.asset(
        'assets/images/conduit.png',
        width: 40.0,
        height: 40.0,
      ),
      *
       */
      applicationVersion: 'Version: 1.0.0',
      applicationLegalese: '© ${DateTime.now().year} RealWorld',
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: aboutTextStyle,
                  text: 'Thank you for using this app.\n\n',
                ),
                _LinkTextSpan(
                  style: linkStyle,
                  url: 'https://github.com/rhalff/realworld-flutter-app',
                  text: 'Visit the repo',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
          style: style,
          text: text ?? url,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(url, forceSafariVC: false);
            },
        );
}
