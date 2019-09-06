import 'package:flutter/material.dart';
import 'package:realworld_flutter/routes.dart';

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
      navigatorKey: navigatorKey,
      onGenerateRoute: routes(),
    );
  }
}
