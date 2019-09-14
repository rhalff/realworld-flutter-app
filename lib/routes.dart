import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';
import 'package:realworld_flutter/screens/article.dart';
import 'package:realworld_flutter/screens/article_editor.dart';
import 'package:realworld_flutter/screens/hero_splash.dart';
import 'package:realworld_flutter/screens/home.dart';
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
import 'screens/hero_splash.dart';

var bootStage = 1;

RouteFactory routes({
  @required Application application,
}) {
  return (RouteSettings settings) {
    Widget screen;
    if (bootStage == 1) {
      bootStage = 2;

      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => HeroSplash(),
      );
    }
    final arguments = settings.arguments as Map<String, dynamic> ?? {};

    switch (settings.name) {
      case HomeScreen.route:
        screen = MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ArticlesRepository>.value(
              value: application.articlesRepository,
            ),
          ],
          child: HomeScreen(
            userBloc: application.userBloc,
          ),
        );
        break;
      case ProfileScreen.route:
        screen = BlocProvider(
            builder: (context) => ProfileBloc(
                  userRepository: application.userRepository,
                )..dispatch(LoadProfileEvent(
                    username: arguments['username'] as String)),
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider<ArticlesRepository>.value(
                  value: application.articlesRepository,
                ),
              ],
              child: ProfileScreen(
                userBloc: application.userBloc,
                feed: arguments['feed'] as String,
              ),
            ));
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
              userBloc: application.userBloc,
              slug: arguments['slug'] as String,
            ),
          ),
        );
        break;
      case ArticleEditorScreen.route:
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ArticleBloc>(
              builder: (_) => ArticleBloc(
                articlesRepository: application.articlesRepository,
              ),
            ),
          ],
          child: ArticleEditorScreen(
            slug: arguments['slug'] as String,
            userBloc: application.userBloc,
          ),
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

    if (bootStage == 2) {
      bootStage = 3;

      return PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }

    return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return screen;
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return FadeTransition(opacity: animation, child: child);
    });
  };
}
