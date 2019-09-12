import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/comment.dart';

import 'article_meta.dart';

class ArticleComment extends StatelessWidget {
  final Comment comment;
  final Function(int id) onRemove;
  ArticleComment({
    Key key,
    this.comment,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(comment.body),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0XFFF5F5F5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ArticleMeta(
                    author: comment.author.username,
                    date: comment.createdAt,
                    avatar: comment.author.image,
                  ),
                  if (onRemove != null)
                    IconButton(
                      onPressed: () => onRemove(comment.id),
                      icon: Icon(Icons.delete),
                    )
                ],
              ))
        ],
      ),
    );
  }
}
