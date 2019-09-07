import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/screens/new_post.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/screens/sign_in.dart';
import 'package:realworld_flutter/screens/sign_up.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

import 'application.dart';
import 'blocs/articles/articles_bloc.dart';

RouteFactory routes({
  @required Application application,
}) {
  return (RouteSettings settings) {
    Widget screen;

    switch (settings.name) {
      case HomeScreen.route:
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ArticlesBloc>.value(
              value: application.articlesBloc,
            ),
          ],
          child: HomeScreen(),
        );
        break;
      case NewPostScreen.route:
        screen = NewPostScreen();
        break;
      case SignUpScreen.route:
        screen = SignUpScreen();
        break;
      case SignInScreen.route:
        screen = SignInScreen();
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
      return FadeTransition(opacity: animation, child: child);
    });
  };
}
