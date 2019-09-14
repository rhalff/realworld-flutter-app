import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/articles/articles_list.dart';
import 'package:realworld_flutter/screens/article_editor.dart';
import 'package:realworld_flutter/screens/profile.dart';
import 'package:realworld_flutter/widgets/header.dart';
import 'package:realworld_flutter/widgets/user_avatar.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ArticlesBloc _articlesBloc;
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );

    _userBloc = BlocProvider.of<UserBloc>(context);
    _articlesBloc = BlocProvider.of<ArticlesBloc>(context)
      ..dispatch(LoadArticlesEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadTab(int index) {
    if (index == 0) {
      _articlesBloc.dispatch(LoadArticlesEvent(refresh: true));
    } else {
      _articlesBloc.dispatch(LoadArticlesFeedEvent(refresh: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              bloc: _userBloc,
              builder: (BuildContext context, UserState state) {
                if (state is UserLoaded) {
                  return SizedBox(
                    height: 210,
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          UserAvatar(
                            radius: 36,
                            avatar: state.user.image,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.user.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RawMaterialButton(
                            constraints: const BoxConstraints(
                              minWidth: 10.0,
                              minHeight: 36.0,
                            ),
                            child: const Text('View Profile'),
                            onPressed: () =>
                                Navigator.of(context).popAndPushNamed(
                              ProfileScreen.route,
                              arguments: {
                                'username': state.user.username,
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return Container();
              },
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Favorited'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('New Article'),
              onTap: () {
                Navigator.of(context)
                    .popAndPushNamed(ArticleEditorScreen.route);
              },
            ),
            ListTile(
              title: const Text('Articles'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Hero(
            tag: 'header',
            child: const Header(
              title: 'conduit',
              subtitle: 'A place to share your knowledge.',
              padding: EdgeInsets.only(top: 8, bottom: 26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              child: TabBar(
                onTap: _loadTab,
                controller: _tabController,
                tabs: <Widget>[
                  const Tab(text: 'Your Feed'),
                  const Tab(text: 'Global Feed'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: AnimatedBuilder(
              animation: _tabController.animation,
              builder: (BuildContext context, snapshot) {
                print(_tabController.animation.value);
                return TabBarView(
                  controller: _tabController,
                  children: [
                    Opacity(
                      opacity: _tabController.index == 0
                          ? 1 - _tabController.animation.value
                          : 1,
                      child: ArticlesList(
                        onFavorited: _onFavorited,
                        onLoadMore: () {
                          _articlesBloc.dispatch(LoadArticlesEvent());
                        },
                        onRefresh: () async {
                          _articlesBloc.dispatch(
                            LoadArticlesEvent(refresh: true),
                          );
                        },
                      ),
                    ),
                    Opacity(
                      opacity: _tabController.index == 1
                          ? _tabController.animation.value
                          : 1,
                      child: ArticlesList(
                        onFavorited: _onFavorited,
                        onLoadMore: () {
                          _articlesBloc.dispatch(LoadArticlesFeedEvent());
                        },
                        onRefresh: () async {
                          _articlesBloc.dispatch(
                            LoadArticlesFeedEvent(refresh: true),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _onFavorited(String slug) {
    _articlesBloc.dispatch(
      ToggleFavoriteEvent(
        slug: slug,
      ),
    );
  }
}
