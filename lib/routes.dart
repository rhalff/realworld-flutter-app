import 'package:flutter/material.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/screens/new_post.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/screens/sign_up.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

RouteFactory routes() {
  // @required Application application,
  // }) {
  return (RouteSettings settings) {
    Widget screen;

    switch (settings.name) {
      case HomeScreen.route:
        screen = HomeScreen();
        break;
      case NewPostScreen.route:
        screen = NewPostScreen();
        break;
      case SignUpScreen.route:
        screen = SignUpScreen();
        break;
      case SettingsScreen.route:
        screen = SettingsScreen();
        break;
      default:
        screen = ErrorContainer(
          title: 'Route ${settings.name} not found',
        );
    }

    return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return screen;
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return new FadeTransition(opacity: animation, child: child);
    });
  };
}
