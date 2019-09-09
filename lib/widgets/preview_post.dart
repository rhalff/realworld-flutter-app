import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'article_meta.dart';
import 'favorite_button.dart';

class PreviewPost extends StatelessWidget {
  final String avatar;
  final String author;
  final DateTime date;
  final String title;
  final String text;
  final bool favorited;
  final int favorites;
  final VoidCallback onTap;
  PreviewPost({
    this.avatar,
    this.author,
    this.date,
    this.title,
    this.text,
    this.favorited,
    this.favorites,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: const Color(0X16000000),
          ),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ArticleMeta(
                avatar: avatar,
                author: author,
                date: date,
              ),
              FavoriteButton(
                favorites: favorites,
                favorited: favorited,
              ),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'MerriweatherSans',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'SourceSerifPro',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
