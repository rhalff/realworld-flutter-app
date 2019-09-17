import 'package:flutter/material.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/pages/articles/preview_post.dart';
import 'package:realworld_flutter/screens/article.dart';

@immutable
class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreviewPost(
      slug: article.slug,
      author: article.author.username,
      avatar: article.author.image,
      date: article.createdAt,
      title: article.title,
      text: article.description,
      favorited: article.favorited,
      favorites: article.favoritesCount,
      onTap: () {
        Navigator.of(context).pushNamed(
          ArticleScreen.route,
          arguments: {
            'slug': article.slug,
          },
        );
      },
    );
  }
}
