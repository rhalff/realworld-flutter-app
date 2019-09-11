import 'package:flutter/material.dart';
import 'package:realworld_flutter/api/model/new_article.dart';
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
    min: 1,
    max: 500,
  )
  String description;

  @NotEmpty()
  String body;

  @NotEmpty()
  List<String> tags;
}

@GenValidator(fields: {})
class PostDataValidator extends Validator<PostData> with _$PostDataValidator {}

class NewPostForm extends StatefulWidget {
  final String error;
  final Function(NewArticle article) onSave;
  NewPostForm({
    this.error,
    this.onSave,
  });
  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = PostData();
  // ArticleBloc _articleBloc;
  PostDataValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = PostDataValidator();

    // _articleBloc = BlocProvider.of<ArticleBloc>(context);
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          createTextField(
            hintText: 'What\'s this article about?',
            // focusNode: _emailFocus,
            validator: _validator.validateDescription,
            onSaved: (String value) {
              setState(() {
                _data.description = value;
              });
            },
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          createTextField(
            hintText: 'Enter tags',
            autovalidate: false,
            // focusNode: _passwordFocus,
            onChanged: (String value) {
              _data.tags = value?.split(' ') ?? [];
            },
            validator: _validator.validateTags,
          ),
          const SizedBox(height: 8),
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

      widget?.onSave(
        NewArticle(
          title: _data.title,
          description: _data.description,
          body: _data.body,
          tagList: _data.tags,
        ),
      );
    }
  }
}
