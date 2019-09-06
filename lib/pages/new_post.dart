import 'package:flutter/material.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';
import 'package:validations/validations.dart';

part 'new_post.g.dart';

class PostData {
  @Size(
    min: 2,
    max: 255,
  )
  String title;

  @NotEmpty()
  @Size(
    min: 10,
    max: 255,
  )
  String body;

  @NotEmpty()
  String tags;
}

@GenValidator()
class PostDataValidator extends Validator<PostData> with _$PostDataValidator {}

class NewPostForm extends StatefulWidget {
  final String error;
  NewPostForm({this.error});
  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = PostData();
  // CustomerBloc _customerBloc;
  PostDataValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = PostDataValidator();

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
          SizedBox(height: 16),
          createTextField(
            hintText: 'Title',
            // focusNode: _emailFocus,
            validator: _validator.validateTitle,
            onSaved: (String value) {
              setState(() {
                _data.title = value;
              });
            },
          ),
          SizedBox(height: 16),
          createTextField(
            hintText: 'Write your post (in markdown)',
            maxLines: 8,
            // focusNode: _emailFocus,
            validator: _validator.validateBody,
            onSaved: (String value) {
              setState(() {
                _data.body = value;
              });
            },
          ),
          SizedBox(height: 16),
          createTextField(
            hintText: 'Enter tags',
            autovalidate: false,
            // focusNode: _passwordFocus,
            onChanged: (String value) {
              _data.tags = value;
            },
            validator: _validator.validateTags,
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              text: 'Create Post',
              onPressed: _updateNewPost,
            ),
          ),
        ],
      ),
    );
  }

  void _updateNewPost() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      /*
      _customerBloc.dispatch(
        NewPost(
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
