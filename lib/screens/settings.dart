import 'package:flutter/material.dart' hide Banner;
import 'package:realworld_flutter/layout.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = '/settings';

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              child: Text('Settings'),
            ),
          ),
        ],
      ),
    );
  }
}
