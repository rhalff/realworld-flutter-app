import 'package:flutter/material.dart';
import 'package:realworld_flutter/api/model/article_submission.dart';
import 'package:realworld_flutter/helpers/form.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

class ArticleForm extends StatefulWidget {
  final String error;
  final Function(ArticleSubmission article) onSave;
  final Article article;

  ArticleForm({
    this.article,
    this.error,
    this.onSave,
  });

  @override
  _ArticleFormState createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = ArticleSubmission();
  ArticleSubmissionValidator _validator;

  @override
  void initState() {
    super.initState();

    _validator = ArticleSubmissionValidator();
  }

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);

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
            initialValue: widget.article?.title,
            hintText: locale.articleFormTitle,
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
            initialValue: widget.article?.description,
            hintText: locale.articleFormDescription,
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
            initialValue: widget.article?.body,
            hintText: locale.articleFormBody,
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
            initialValue: widget.article?.tagList?.join(' '),
            hintText: locale.articleFormTags,
            autovalidate: false,
            // focusNode: _passwordFocus,
            onChanged: (String value) {
              _data.tagList = value?.split(' ') ?? [];
            },
            // validator: _validator.validateTagList,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              text: widget.article == null
                  ? locale.articleFormCreateArticle
                  : locale.articleFormUpdateArticle,
              onPressed: _saveArticle,
            ),
          ),
        ],
      ),
    );
  }

  void _saveArticle() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget?.onSave(
        ArticleSubmission(
          title: _data.title,
          description: _data.description,
          body: _data.body,
          tagList: _data.tagList,
        ),
      );
    }
  }
}
