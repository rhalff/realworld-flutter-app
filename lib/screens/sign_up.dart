import 'package:flutter/material.dart' hide Banner;
import 'package:realworld_flutter/layout.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              child: Text('SignUp'),
            ),
          ),
        ],
      ),
    );
  }
}
