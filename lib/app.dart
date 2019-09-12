import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application.dart';
import 'blocs/user/bloc.dart';
import 'model/user.dart';
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
    return BlocBuilder<UserBloc, UserState>(
      builder: (BuildContext context, UserState state) {
        User user;

        if (state is UserLoaded) {
          user = state.user;
        }

        return MaterialApp(
          title: 'RealWorld App',
          theme: ThemeData(
            fontFamily: 'SourceSansPro',
            primaryColor: const Color(0xFF5CB85C),
          ),
          // navigatorKey: navigatorKey,
          onGenerateRoute: routes(
            user: user,
            application: application,
          ),
        );
      },
    );
  }
}
