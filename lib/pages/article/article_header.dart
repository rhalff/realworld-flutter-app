import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/widgets/header.dart';

import 'article_meta.dart';

class ArticleHeader extends StatelessWidget {
  final Article article;

  ArticleHeader({
    this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Header(
      title: article.title,
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: const EdgeInsets.only(
        bottom: 18,
        left: 18,
        right: 18,
      ),
      color: const Color(0XFF3333333),
      child: ArticleMeta(
        avatar: article.author.image,
        author: article.author.username,
        date: article.createdAt,
        color: Colors.white,
      ),
    );
  }
}
