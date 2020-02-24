import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/blocs/auth/bloc.dart';
import 'package:realworld_flutter/blocs/user_profile/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/pages/profile/profile_form.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class ProfileEditorScreen extends StatefulWidget {
  static const String route = '/profile_editor';

  @override
  _ProfileEditorScreenState createState() => _ProfileEditorScreenState();
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  AuthBloc _authBloc;
  UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.of<AuthBloc>(context);
    _userProfileBloc = BlocProvider.of<UserProfileBloc>(context)
      ..add(LoadUserProfileEvent());
  }

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
                    locale.profileEdit,
                    style: theme.textTheme.headline6.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ProfileForm(
                  onSave: _onSave,
                  onLogout: _onLogout,
                )),
          ],
        ),
      ),
    );
  }

  void _onLogout() {
    _authBloc.add(
      SignOutEvent(
        onComplete: () =>
            Navigator.of(context).pushReplacementNamed(HomeScreen.route),
      ),
    );
  }

  void _onSave(UpdateUser user) {
    _userProfileBloc.add(UpdateUserProfileEvent(user));
  }
}
