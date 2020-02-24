import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/favorite/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/repositories/articles/repository.dart';
import 'package:realworld_flutter/widgets/favorite_button.dart';

import '../article/article_meta.dart';

class PreviewPost extends StatelessWidget {
  final String slug;
  final String avatar;
  final String author;
  final DateTime date;
  final String title;
  final String text;
  final bool favorited;
  final int favorites;
  final VoidCallback onTap;

  PreviewPost({
    @required this.slug,
    @required this.avatar,
    @required this.author,
    @required this.date,
    @required this.title,
    @required this.text,
    @required this.favorited,
    @required this.favorites,
    @required this.onTap,
  }) : super(key: Key(slug));

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = FavoriteBloc(
      articlesRepository: RepositoryProvider.of<ArticlesRepository>(context),
    );

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: const Border(
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
              ArticleMeta(
                avatar: avatar,
                author: author,
                date: date,
              ),
              BlocProvider(
                create: (context) => favoriteBloc,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (BuildContext context, UserState state) {
                    final user = (state is UserLoaded) ? state.user : null;

                    return FavoriteButton(
                      slug: slug,
                      favorites: favorites,
                      favorited: favorited,
                      enabled: user != null,
                    );
                  },
                ),
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
                    style: const TextStyle(
                      fontFamily: 'MerriweatherSans',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
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
