import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/login_user.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = LoginUser();
  UserBloc _userBloc;
  LoginUserValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = LoginUserValidator();

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
                // focusNode: _emailFocus,
                hintText: locale.userSignInFormEmail,
                autovalidate: false,
                keyboardType: TextInputType.emailAddress,
                validator: _validator.validateEmail,
                onSaved: (String value) {
                  setState(() {
                    _data.email = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              createTextField(
                hintText: locale.userSignInFormPassword,
                obscureText: true,
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
                  text: locale.userSignInFormSignIn,
                  onPressed: _signIn,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _signIn() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _userBloc.add(SignInEvent(_data));
    }
  }
}
