import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

import 'article_widget.dart';

class Feed extends StatefulWidget {
  final String id;
  final String label;
  final Function(ArticlesBloc bloc) onRefresh;
  final Function(ArticlesBloc bloc) onLoad;
  final Function(ArticlesBloc bloc) onLoadMore;
  final Function(ArticlesBloc bloc, String slug) onFavorited;
  final double scrollThreshold;
  Feed({
    @required this.id,
    @required this.label,
    @required this.onRefresh,
    @required this.onLoad,
    @required this.onLoadMore,
    @required this.onFavorited,
    this.scrollThreshold = 400.0,
  });
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _scrollController = ScrollController();
  double _scrollMarker = 0;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articlesBloc = BlocProvider.of<ArticlesBloc>(context);

    if (_articlesBloc.currentState is! ArticlesLoaded) {
      widget.onLoad(_articlesBloc);
    }
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
            return const Center(
              child: Text('no articles'),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ArticleWidget(
                  article: articles[index],
                  onFavorited: () => widget.onFavorited(
                    _articlesBloc,
                    articles[index].slug,
                  ),
                );
              },
              itemCount: articles.length,
              controller: _scrollController,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
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
        widget.onLoadMore(_articlesBloc);
      }
    }
  }

  Future<void> _onRefresh() async {
    widget.onRefresh(_articlesBloc);
  }
}
