import 'package:flutter/material.dart';
import 'package:realworld_flutter/api/model/new_article.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

class NewArticleForm extends StatefulWidget {
  final String error;
  final Function(NewArticle article) onSave;
  NewArticleForm({
    this.error,
    this.onSave,
  });
  @override
  _NewArticleFormState createState() => _NewArticleFormState();
}

class _NewArticleFormState extends State<NewArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = NewArticle();
  NewArticleValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = NewArticleValidator();
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
              _data.tagList = value?.split(' ') ?? [];
            },
            validator: _validator.validateTagList,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              text: 'Create article',
              onPressed: _updateNewArticle,
            ),
          ),
        ],
      ),
    );
  }

  void _updateNewArticle() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget?.onSave(
        NewArticle(
          title: _data.title,
          description: _data.description,
          body: _data.body,
          tagList: _data.tagList,
        ),
      );
    }
  }
}
