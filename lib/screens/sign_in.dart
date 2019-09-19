import 'package:flutter/material.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/pages/signin_form.dart';
import 'package:realworld_flutter/screens/sign_up.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class SignInScreen extends StatelessWidget {
  static const String route = '/sign_in';

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);
    final theme = Theme.of(context);
    return Layout(
      child: ScrollPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: <Widget>[
                  Text(
                    locale.userSignIn,
                    style: theme.textTheme.title.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.route);
                      },
                      child: Text(
                        locale.userSignInNoAccount,
                        style: theme.textTheme.subtitle,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SignInForm(),
            ),
          ],
        ),
      ),
    );
  }
}
