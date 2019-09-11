import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/blocs/auth/auth_bloc.dart';
import 'package:realworld_flutter/blocs/auth/auth_events.dart';
import 'package:realworld_flutter/blocs/user/blocs.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';
import 'package:validations/validations.dart';

part 'settings.g.dart';

class SettingsData {
  @Size(
    min: 2,
    max: 255,
  )
  String pictureUrl;

  @Size(
    min: 2,
    max: 255,
  )
  String name;

  String bio;

  @Email()
  @NotEmpty()
  String email;

  @NotEmpty()
  @Size(
    min: 2,
    max: 20,
    message: r'password length must be between $min and $max',
  )
  String password;
}

@GenValidator()
class SettingsDataValidator extends Validator<SettingsData>
    with _$SettingsDataValidator {}

class SettingsForm extends StatefulWidget {
  final String error;
  SettingsForm({this.error});
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = SettingsData();
  UserBloc _userBloc;
  AuthBloc _authBloc;
  SettingsDataValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = SettingsDataValidator();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (widget.error != null)
            ErrorContainer(
              error: widget.error,
            ),
          createTextField(
            hintText: 'URL of profile picture',
            contentPadding: const EdgeInsets.all(8),
            // focusNode: _emailFocus,
            validator: _validator.validatePictureUrl,
            onSaved: (String value) {
              setState(() {
                _data.pictureUrl = value;
              });
            },
          ),
          const SizedBox(height: 16),
          createTextField(
            hintText: 'Your Name',
            // focusNode: _emailFocus,
            validator: _validator.validateName,
            onSaved: (String value) {
              setState(() {
                _data.name = value;
              });
            },
          ),
          const SizedBox(height: 16),
          createTextField(
            hintText: 'Short bio about you',
            maxLines: 8,
            // focusNode: _emailFocus,
            validator: _validator.validateName,
            onSaved: (String value) {
              setState(() {
                _data.name = value;
              });
            },
          ),
          const SizedBox(height: 16),
          createTextField(
            // focusNode: _emailFocus,
            hintText: 'Email',
            autovalidate: false,
            validator: _validator.validateEmail,
            onSaved: (String value) {
              setState(() {
                _data.email = value;
              });
            },
          ),
          const SizedBox(height: 16),
          createTextField(
            hintText: 'Password',
            autovalidate: false,
            // focusNode: _passwordFocus,
            onChanged: (String value) {
              _data.password = value;
            },
            validator: _validator.validatePassword,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              text: 'Update Settings',
              onPressed: _updateSettings,
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: RoundedButton(
              text: 'Or click here to logout.',
              onPressed: _logout,
            ),
          ),
        ],
      ),
    );
  }

  void _logout() {
    _authBloc.dispatch(SignOutEvent());
  }

  void _updateSettings() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _userBloc.dispatch(
        UpdateUserEvent(
          UpdateUser(
            username: _data.name,
            email: _data.email,
            bio: _data.bio,
            image: _data.pictureUrl,
          ),
        ),
      );

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: const Text('Processing Data')));
    }
  }
}
