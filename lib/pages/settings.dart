import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
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
  // CustomerBloc _customerBloc;
  SettingsDataValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = SettingsDataValidator();

    // _customerBloc = BlocProvider.of<CustomerBloc>(context);
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
            contentPadding: prefix0.EdgeInsets.all(8),
            // focusNode: _emailFocus,
            validator: _validator.validatePictureUrl,
            onSaved: (String value) {
              setState(() {
                _data.pictureUrl = value;
              });
            },
          ),
          SizedBox(height: 16),
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
          SizedBox(height: 16),
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
          SizedBox(height: 16),
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
          SizedBox(height: 16),
          createTextField(
            hintText: 'Password',
            autovalidate: false,
            // focusNode: _passwordFocus,
            onChanged: (String value) {
              _data.password = value;
            },
            validator: _validator.validatePassword,
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              text: 'Sign Up',
              onPressed: _updateSettings,
            ),
          ),
        ],
      ),
    );
  }

  void _updateSettings() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      /*
      _customerBloc.dispatch(
        Settings(
          name: _data.name,
          email: _data.email,
          password: _data.password,
        ),
      );
       */

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: const Text('Processing Data')));
    }
  }
}
