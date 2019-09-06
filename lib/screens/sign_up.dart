import 'package:flutter/material.dart' hide Banner;
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/signup_form.dart';
import 'package:realworld_flutter/screens/sign_in.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = '/sign_up';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Layout(
      child: ScrollPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Sign up',
                    style: theme.textTheme.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignInScreen.route);
                      },
                      child: Text(
                        'Have an account?',
                        style: theme.textTheme.subtitle,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}
