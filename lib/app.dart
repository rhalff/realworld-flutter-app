import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';

import 'application.dart';
import 'blocs/user/bloc.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@immutable
class RealWorldApp extends StatelessWidget {
  final Application application;
  const RealWorldApp({
    this.application,
  });
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ArticlesRepository>.value(
          value: application.articlesRepository,
        ),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState state) {
          return MaterialApp(
            title: 'RealWorld App',
            color: Colors.green,
            theme: ThemeData(
              fontFamily: 'SourceSansPro',
              primaryColor: const Color(0xFF5CB85C),
            ),
            // navigatorKey: navigatorKey,
            onGenerateRoute: routes(
              application: application,
            ),
          );
        },
      ),
    );
  }
}
