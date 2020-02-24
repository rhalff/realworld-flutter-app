import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/pages/articles/app_drawer.dart';
import 'package:realworld_flutter/pages/articles/feed.dart';
import 'package:realworld_flutter/pages/articles/feeds.dart';
import 'package:realworld_flutter/widgets/header.dart';

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
    final locale = RWLocalizations.of(context);

    return BlocBuilder<UserBloc, UserState>(
      bloc: widget.userBloc,
      builder: (BuildContext context, UserState state) {
        User user;

        final feeds = <FeedModel>[
          FeedModel(
            id: 'global-feed',
            label: locale.globalFeed,
            onLoad: (ArticlesBloc bloc) {
              bloc.add(LoadArticlesEvent(refresh: true));
            },
            onLoadMore: (ArticlesBloc bloc) {
              bloc.add(LoadArticlesEvent());
            },
            onRefresh: (ArticlesBloc bloc) async {
              bloc.add(LoadArticlesEvent(refresh: true));
            },
          ),
        ];

        if (state is UserLoaded) {
          feeds.add(
            FeedModel(
              id: 'your-feed',
              label: locale.yourFeed,
              onLoad: (ArticlesBloc bloc) {
                bloc.add(LoadArticlesFeedEvent(refresh: true));
              },
              onLoadMore: (ArticlesBloc bloc) {
                bloc.add(LoadArticlesFeedEvent());
              },
              onRefresh: (ArticlesBloc bloc) async {
                bloc.add(LoadArticlesFeedEvent(refresh: true));
              },
            ),
          );
          user = state.user;
        } else {
          feeds.add(
            FeedModel(
              id: 'your-feed',
              label: locale.yourFeed,
              child: Container(
                padding: const EdgeInsets.all(80),
                width: 250,
                child: Text(
                  locale.yourFeedLogin,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return Layout(
          drawer: user != null ? Drawer(child: AppDrawer(user: user)) : null,
          child: Feeds(
            header: Header(
              title: locale.appTitle,
              subtitle: locale.appSubtitle,
              padding: const EdgeInsets.only(top: 8, bottom: 26),
              fit: BoxFit.scaleDown,
            ),
            feeds: feeds,
          ),
        );
      },
    );
  }
}

class HeroHeader implements SliverPersistentHeaderDelegate {
  @override
  double maxExtent;
  @override
  double minExtent;
  Widget child;

  HeroHeader({
    this.minExtent,
    this.maxExtent,
    this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final h = maxExtent - shrinkOffset;
    return Hero(
      tag: 'header',
      child: SizedBox(
        height: (h < minExtent) ? minExtent : h,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
