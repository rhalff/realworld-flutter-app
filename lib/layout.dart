import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/screens/sign_in.dart';
import 'package:realworld_flutter/screens/sign_up.dart';

import 'blocs/user/bloc.dart';

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
  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocBuilder(
      bloc: _userBloc,
      builder: (BuildContext context, UserState state) {
        return Scaffold(
          drawer: widget.drawer,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: <Widget>[
              if (state is! UserLoaded)
                RawMaterialButton(
                  child: Text(locale.userSignIn),
                  constraints:
                      const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
                  padding: const EdgeInsets.all(3),
                  onPressed: _navigateTo(context, SignInScreen.route),
                ),
              if (state is! UserLoaded)
                RawMaterialButton(
                  child: Text(locale.userSignUp),
                  constraints:
                      const BoxConstraints(minWidth: 28.0, minHeight: 36.0),
                  padding: const EdgeInsets.all(3),
                  onPressed: _navigateTo(context, SignUpScreen.route),
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
