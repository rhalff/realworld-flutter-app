import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';
import 'package:realworld_flutter/screens/article.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/screens/new_article.dart';
import 'package:realworld_flutter/screens/profile.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/screens/sign_in.dart';
import 'package:realworld_flutter/screens/sign_up.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

import 'application.dart';
import 'blocs/article/bloc.dart';
import 'blocs/articles/bloc.dart';
import 'blocs/profile/bloc.dart';
import 'blocs/user_profile/bloc.dart';
import 'model/user.dart';

RouteFactory routes({
  User user,
  @required Application application,
}) {
  return (RouteSettings settings) {
    Widget screen;

    final arguments = settings.arguments as Map<String, dynamic> ?? {};

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
      case ProfileScreen.route:
        screen = BlocProvider(
          builder: (context) => ProfileBloc(
            userRepository: application.userRepository,
          ),
          child: ProfileScreen(
            user: user,
            username: arguments['username'] as String,
          ),
        );
        break;
      case ArticleScreen.route:
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ArticleBloc>.value(
              value: application.articleBloc,
            ),
            BlocProvider<ArticlesBloc>.value(
              value: application.articlesBloc,
            ),
          ],
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<ArticlesRepository>.value(
                value: application.articlesRepository,
              ),
            ],
            child: ArticleScreen(
              slug: arguments['slug'] as String,
            ),
          ),
        );
        break;
      case NewArticleScreen.route:
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ArticleBloc>.value(
              value: application.articleBloc,
            ),
          ],
          child: NewArticleScreen(),
        );
        break;
      case SignUpScreen.route:
        screen = SignUpScreen();
        break;
      case SignInScreen.route:
        screen = SignInScreen();
        break;
      case SettingsScreen.route:
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ArticlesBloc>.value(
              value: application.articlesBloc,
            ),
            BlocProvider<UserProfileBloc>(
              builder: (context) => UserProfileBloc(
                articlesBloc: application.articlesBloc,
                userBloc: application.userBloc,
                userRepository: application.userRepository,
              ),
            ),
          ],
          child: SettingsScreen(),
        );
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
