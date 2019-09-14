import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/comment.dart';
import 'package:realworld_flutter/model/user.dart';

import 'article_comment.dart';

class ArticleComments extends StatelessWidget {
  final User user;
  final List<Comment> comments;
  final Function(int id) onRemove;

  ArticleComments({
    Key key,
    this.user,
    this.comments,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: comments.map(
      (Comment comment) {
        return Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ArticleComment(
            comment: comment,
            onRemove:
                comment.author.username == user?.username ? onRemove : null,
          ),
        );
      },
    ).toList());
  }
}
