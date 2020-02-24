import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/new_user.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _newUser = NewUser();
  UserBloc _userBloc;
  NewUserValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = NewUserValidator();

    _userBloc = BlocProvider.of<UserBloc>(context)..add(ClearUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);

    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state is UserLoaded) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
          builder: (BuildContext context, UserState state) {
        if (state is UserLoaded || state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        String error;
        if (state is UserError) {
          error = state.errors.join('\n\n');
        }

        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              if (error != null)
                ErrorContainer(
                  error: error,
                ),
              const SizedBox(height: 16),
              createTextField(
                hintText: locale.userSignUpFormName,
                // focusNode: _emailFocus,
                validator: _validator.validateUsername,
                onSaved: (String value) {
                  setState(() {
                    _newUser.username = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              createTextField(
                // focusNode: _emailFocus,
                hintText: locale.userSignUpFormEmail,
                autovalidate: false,
                keyboardType: TextInputType.emailAddress,
                validator: _validator.validateEmail,
                onSaved: (String value) {
                  setState(() {
                    _newUser.email = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              createTextField(
                hintText: locale.userSignUpFormPassword,
                autovalidate: false,
                obscureText: true,
                // focusNode: _passwordFocus,
                onChanged: (String value) {
                  _newUser.password = value;
                },
                validator: _validator.validatePassword,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: RoundedButton(
                  text: locale.userSignUpFormSignUp,
                  onPressed: _signUp,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _userBloc..add(SignUpEvent(_newUser));
    }
  }
}
