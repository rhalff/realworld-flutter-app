import 'package:flutter/material.dart';

import 'application.dart';
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
    return MaterialApp(
      title: 'RealWorld App',
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        primaryColor: const Color(0xFF5CB85C),
      ),
      // navigatorKey: navigatorKey,
      onGenerateRoute: routes(
        application: application,
      ),
    );
  }
}
