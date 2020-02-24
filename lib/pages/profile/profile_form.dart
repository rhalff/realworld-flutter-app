import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/blocs/user_profile/bloc.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

class ProfileForm extends StatefulWidget {
  final String error;
  final Function(UpdateUser user) onSave;
  final VoidCallback onLogout;

  ProfileForm({
    this.error,
    this.onSave,
    this.onLogout,
  });

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _updateUser = UpdateUser();
  UpdateUserValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = UpdateUserValidator();
  }

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (BuildContext context, UserProfileState state) {
        if (state is UserProfileLoaded) {
          final user = state.user;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                if (widget.error != null)
                  ErrorContainer(
                    error: widget.error,
                  ),
                createTextField(
                  initialValue: user.image,
                  hintText: locale.profileFormImage,
                  contentPadding: const EdgeInsets.all(8),
                  // focusNode: _emailFocus,
                  validator: _validator.validateImage,
                  onSaved: (String value) {
                    setState(() {
                      _updateUser.image = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                createTextField(
                  initialValue: user.username,
                  hintText: locale.profileFormUsername,
                  // focusNode: _emailFocus,
                  validator: _validator.validateUsername,
                  onSaved: (String value) {
                    setState(() {
                      _updateUser.username = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                createTextField(
                  initialValue: user.bio,
                  hintText: locale.profileFormBio,
                  maxLines: 8,
                  // focusNode: _emailFocus,
                  validator: _validator.validateBio,
                  onSaved: (String value) {
                    setState(() {
                      _updateUser.bio = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                createTextField(
                  // focusNode: _emailFocus,
                  initialValue: user.email,
                  hintText: locale.profileFormEmail,
                  autovalidate: false,
                  validator: _validator.validateEmail,
                  onSaved: (String value) {
                    setState(() {
                      _updateUser.email = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: RoundedButton(
                    text: locale.profileFormUpdateProfile,
                    onPressed: _onSave,
                  ),
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RoundedButton(
                    text: locale.profileFormLogout,
                    onPressed: widget.onLogout,
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget.onSave(_updateUser);
    }
  }
}
