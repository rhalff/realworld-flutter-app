import 'package:flutter/material.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/articles/feed.dart';
import 'package:realworld_flutter/pages/articles/feeds.dart';
import 'package:realworld_flutter/widgets/header.dart';

final feeds = [
  Feed(
    id: 'your-feed',
    label: 'Your Feed',
    onFavorited: (ArticlesBloc bloc, String slug) {
      bloc.dispatch(
        ToggleFavoriteEvent(
          slug: slug,
        ),
      );
    },
    onLoad: (ArticlesBloc bloc) {
      bloc.dispatch(LoadArticlesEvent(refresh: true));
    },
    onLoadMore: (ArticlesBloc bloc) {
      bloc.dispatch(LoadArticlesEvent());
    },
    onRefresh: (ArticlesBloc bloc) async {
      bloc.dispatch(
        LoadArticlesEvent(refresh: true),
      );
    },
  ),
  Feed(
    id: 'global-feed',
    label: 'Global Feed',
    onFavorited: (ArticlesBloc bloc, String slug) {
      bloc.dispatch(
        ToggleFavoriteEvent(
          slug: slug,
        ),
      );
    },
    onLoad: (ArticlesBloc bloc) {
      bloc.dispatch(LoadArticlesFeedEvent(refresh: true));
    },
    onLoadMore: (ArticlesBloc bloc) {
      bloc.dispatch(LoadArticlesFeedEvent());
    },
    onRefresh: (ArticlesBloc bloc) async {
      bloc.dispatch(
        LoadArticlesFeedEvent(refresh: true),
      );
    },
  ),
];

class HomeScreen extends StatefulWidget {
  final UserBloc userBloc;
  HomeScreen({
    @required this.userBloc,
  });
  static const String route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Hero(
            tag: 'header',
            child: Header(
              title: 'conduit',
              subtitle: 'A place to share your knowledge.',
              padding: EdgeInsets.only(top: 8, bottom: 26),
            ),
          ),
          Feeds(
            feeds: feeds,
          ),
        ],
      ),
    );
  }
}
