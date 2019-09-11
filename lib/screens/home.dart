import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/articles_bloc.dart';
import 'package:realworld_flutter/blocs/articles/articles_events.dart';
import 'package:realworld_flutter/blocs/articles/articles_state.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/header.dart';
import 'package:realworld_flutter/widgets/preview_post.dart';

import 'article.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Header(
            title: 'conduit',
            subtitle: 'A place to share your knowledge.',
            padding: EdgeInsets.only(top: 8, bottom: 26),
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
                }),
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

class ArticlesList extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final Function(String slug) onFavorited;
  final double scrollThreshold;
  ArticlesList({
    @required this.onRefresh,
    @required this.onLoadMore,
    @required this.onFavorited,
    this.scrollThreshold = 400.0,
  });
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();
  double _scrollMarker = 0;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articlesBloc = BlocProvider.of<ArticlesBloc>(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        if (state is ArticlesError) {
          return ErrorContainer(
            error: 'failed to fetch articles',
          );
        }
        if (state is ArticlesLoaded) {
          final articles = state.articles;
          if (articles.isEmpty) {
            return Center(
              child: const Text('no articles'),
            );
          }

          final itemCount =
              state.hasReachedMax ? articles.length : articles.length + 1;

          return RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= articles.length
                    ? BottomLoader()
                    : ArticleWidget(
                        article: articles[index],
                        onFavorited: () =>
                            widget.onFavorited(articles[index].slug),
                      );
              },
              itemCount: itemCount,
              controller: _scrollController,
            ),
          );
        }
        return Center(
          child: const CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollMarker + widget.scrollThreshold;
    final currentScroll = _scrollController.position.pixels;
    if (_articlesBloc.currentState is ArticlesLoaded) {
      if (!(_articlesBloc.currentState as ArticlesLoaded).hasReachedMax &&
          currentScroll >= maxScroll) {
        _scrollMarker = maxScroll;
        widget.onLoadMore();
      }
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: const SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

@immutable
class ArticleWidget extends StatelessWidget {
  final Article article;
  final VoidCallback onFavorited;

  const ArticleWidget({
    Key key,
    @required this.article,
    this.onFavorited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreviewPost(
      author: article.author.username,
      avatar: article.author.image,
      date: article.createdAt,
      title: article.title,
      text: article.description,
      favorited: article.favorited,
      favorites: article.favoritesCount,
      onFavorited: onFavorited,
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
