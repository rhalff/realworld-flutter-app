import 'package:flutter/material.dart';
import 'package:realworld_flutter/utils.dart';

import 'like_button.dart';

class PreviewPost extends StatelessWidget {
  final String avatar;
  final String author;
  final DateTime date;
  final String title;
  final String text;
  PreviewPost({
    this.avatar,
    this.author,
    this.date,
    this.title,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: Color(0X16000000),
          ),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 14,
                    child: Placeholder(),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        author,
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        formatDate(date),
                        style: TextStyle(
                          color: Color(0XFFBBBBBB),
                          fontSize: 12,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              LikeButton(),
            ],
          ),
          Column(
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
          )
        ],
      ),
    );
  }
}
