import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';

import 'article_meta.dart';

class ArticleCommentForm extends StatefulWidget {
  final User user;
  final Function(String comment) onSubmit;
  ArticleCommentForm({
    Key key,
    this.user,
    this.onSubmit,
  }) : super(key: key);

  @override
  _ArticleCommentFormState createState() => _ArticleCommentFormState();
}

class _ArticleCommentFormState extends State<ArticleCommentForm> {
  final _formKey = GlobalKey<FormState>();

  String _comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Write a comment...',
                    contentPadding: EdgeInsets.all(14),
                  ),
                  minLines: 2,
                  maxLines: 10,
                  onChanged: (String value) {
                    setState(() {
                      _comment = value;
                    });
                  }),
            ),
            Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0XFFF5F5F5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ArticleMeta(
                      author: widget.user.username,
                      avatar: widget.user.image,
                    ),
                    if (_comment != null && _comment.isNotEmpty)
                      RoundedButton(
                        text: 'Post Comment',
                        onPressed: _onSubmit,
                      ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState.validate()) {
      widget.onSubmit(_comment);

      _formKey.currentState.reset();

      setState(() {
        _comment = null;
      });
    }
  }
}
