import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/screens/new_post.dart';
import 'package:realworld_flutter/screens/settings.dart';
import 'package:realworld_flutter/screens/sign_in.dart';
import 'package:realworld_flutter/screens/sign_up.dart';

import 'blocs/auth/bloc.dart';

class Layout extends StatefulWidget {
  final Widget bottomNavigationBar;
  final Widget child;
  final Drawer drawer;
  Layout({
    this.bottomNavigationBar,
    this.drawer,
    this.child,
  });

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          drawer: widget.drawer,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: <Widget>[
              if (state is Authenticated)
                RawMaterialButton(
                  child: const Text('New Post'),
                  constraints:
                      const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
                  padding: const EdgeInsets.all(3),
                  onPressed: _navigateTo(context, NewPostScreen.route),
                ),
              if (state is! Authenticated)
                RawMaterialButton(
                  child: const Text('Sign in'),
                  constraints:
                      const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
                  padding: const EdgeInsets.all(3),
                  onPressed: _navigateTo(context, SignInScreen.route),
                ),
              if (state is! Authenticated)
                RawMaterialButton(
                  child: const Text('Sign up'),
                  constraints:
                      const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
                  padding: const EdgeInsets.all(3),
                  onPressed: _navigateTo(context, SignUpScreen.route),
                ),
              if (state is Authenticated)
                RawMaterialButton(
                  constraints:
                      const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
                  child: const Text('Settings'),
                  padding: const EdgeInsets.all(3),
                  onPressed: _navigateTo(context, SettingsScreen.route),
                ),
              const SizedBox(width: 15),
            ],
            title: SizedBox(
              width: 300,
              child: Text(
                'conduit',
                style: TextStyle(
                  fontFamily: 'Titilliumweb',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
          body: widget.child,
          bottomNavigationBar: widget.bottomNavigationBar,
        );
      },
    );
  }

  void Function() _navigateTo(BuildContext context, String route) {
    return () {
      Navigator.of(context).pushNamedAndRemoveUntil(route, (Route route) {
        return route.isFirst;
      });
    };
  }
}
