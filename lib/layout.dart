import 'package:flutter/material.dart';
import 'package:realworld_flutter/screens/new_post.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/screens/sign_up.dart';

class Layout extends StatelessWidget {
  final Widget child;
  Layout({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            child: const Text('New Post'),
            onPressed: () {
              Navigator.of(context).pushNamed(NewPostScreen.route);
            },
          ),
          FlatButton(
            child: const Text('Sign up'),
            onPressed: () {
              Navigator.of(context).pushNamed(SignUpScreen.route);
            },
          ),
          FlatButton(
            child: const Text('Settings'),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.route);
            },
          ),
        ],
        title: Text(
          'conduit',
          style: TextStyle(
            fontFamily: 'Titilliumweb',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
      ),
      body: child,
    );
  }
}
