import 'package:flutter/material.dart';
import 'package:realworld_flutter/api/model/update_user.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

class SettingsForm extends StatefulWidget {
  final String error;
  final UpdateUser user;
  final Function(UpdateUser user) onSave;
  final VoidCallback onLogout;
  SettingsForm({
    this.user,
    this.error,
    this.onSave,
    this.onLogout,
  });
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (widget.error != null)
            ErrorContainer(
              error: widget.error,
            ),
          createTextField(
            initialValue: widget.user.image,
            hintText: 'URL of profile picture',
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
            initialValue: widget.user.username,
            hintText: 'Your Name',
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
            initialValue: widget.user.bio,
            hintText: 'Short bio about you',
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
            initialValue: widget.user.email,
            hintText: 'Email',
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
              text: 'Update Settings',
              onPressed: _onSave,
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: RoundedButton(
              text: 'Or click here to logout.',
              onPressed: widget.onLogout,
            ),
          ),
        ],
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget.onSave(_updateUser);
    }
  }
}
