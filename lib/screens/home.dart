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

class HomeScreen extends StatelessWidget {
  static const String route = '/';

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
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  // instead of controlling which Widget is shown
                  // we will want to change the provided data.
                  // and thus dispatch a bloc action.
                  // controller: use custom controller,
                  tabs: <Widget>[
                    const Tab(text: 'Your Feed'),
                    const Tab(text: 'Global Feed'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: ArticlesList(),
          ),
        ],
      ),
    );
  }
}

class ArticlesList extends StatefulWidget {
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 400.0;
  double _scrollMarker = 0;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articlesBloc = BlocProvider.of<ArticlesBloc>(context)
      ..dispatch(LoadArticles());
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
            onRefresh: _refresh,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= articles.length
                    ? BottomLoader()
                    : ArticleWidget(article: articles[index]);
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

  Future<void> _refresh() async {
    _articlesBloc.dispatch(LoadArticles(refresh: true));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollMarker +
        _scrollThreshold; // _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    print(currentScroll);
    if (_articlesBloc.currentState is ArticlesLoaded) {
      if (!(_articlesBloc.currentState as ArticlesLoaded).hasReachedMax &&
          currentScroll >= maxScroll) {
        _scrollMarker = maxScroll;
        _articlesBloc.dispatch(LoadArticles());
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

  const ArticleWidget({
    Key key,
    @required this.article,
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
