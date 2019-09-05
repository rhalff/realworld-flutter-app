import 'package:flutter/material.dart';
import 'package:realworld_flutter/routes.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/screens/new_post.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/screens/sign_up.dart';

void main() => runApp(RealWorldApp());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RealWorldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealWorld App',
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        primaryColor: Color(0xFF5CB85C),
      ),
      // home: MyHomePage(),
      navigatorKey: navigatorKey,
      onGenerateRoute: routes(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
      body: HomeScreen(),
    );
  }
}
