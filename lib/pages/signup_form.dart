import 'package:flutter/material.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';
import 'package:validations/validations.dart';

part 'signup_form.g.dart';

class SignUpData {
  @Size(
    min: 2,
    max: 255,
  )
  String name;

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
class SignUpDataValidator extends Validator<SignUpData>
    with _$SignUpDataValidator {}

class SignUpForm extends StatefulWidget {
  final String error;
  SignUpForm({this.error});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = SignUpData();
  // CustomerBloc _customerBloc;
  SignUpDataValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = SignUpDataValidator();

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
              onPressed: _signUp,
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      /*
      _customerBloc.dispatch(
        SignUp(
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
