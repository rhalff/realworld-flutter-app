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
          RawMaterialButton(
            child: const Text('New Post'),
            constraints: const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
            padding: const EdgeInsets.all(3),
            onPressed: _navigateTo(context, NewPostScreen.route),
          ),
          RawMaterialButton(
            child: const Text('Sign up'),
            constraints: const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
            padding: const EdgeInsets.all(3),
            onPressed: _navigateTo(context, SignUpScreen.route),
          ),
          RawMaterialButton(
            constraints: const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
            child: const Text('Settings'),
            padding: const EdgeInsets.all(3),
            onPressed: _navigateTo(context, SettingsScreen.route),
          ),
          SizedBox(width: 15),
        ],
        title: SizedBox(
          width: 300,
          child: Text(
            'conduit',
            style: TextStyle(
              fontFamily: 'Titilliumweb',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
      body: child,
    );
  }

  void Function() _navigateTo(BuildContext context, String route) {
    return () {
      Navigator.of(context).pushNamedAndRemoveUntil(route, (Route route) {
        return route.isFirst;
      });
    };
  }
}
