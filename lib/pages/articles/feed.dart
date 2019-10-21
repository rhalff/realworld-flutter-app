import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/pages/articles/preview_post.dart';
import 'package:realworld_flutter/screens/article.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

class Feed extends StatefulWidget {
  final String id;
  final String label;
  final Function(ArticlesBloc bloc) onRefresh;
  final Function(ArticlesBloc bloc) onLoad;
  final Function(ArticlesBloc bloc) onLoadMore;
  final double scrollThreshold;

  /// The ScrollController itself is handled by the NestedScrollView parent.
  final ScrollController scrollController;
  Feed({
    @required this.id,
    @required this.label,
    @required this.onRefresh,
    @required this.onLoad,
    @required this.onLoadMore,
    @required this.scrollController,
    this.scrollThreshold = 400.0,
  });
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  double _scrollMarker = 0;
  ArticlesBloc _articlesBloc;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
    _articlesBloc = BlocProvider.of<ArticlesBloc>(context);

    if (_articlesBloc.currentState is! ArticlesLoaded) {
      widget.onLoad(_articlesBloc);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
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
                final article = articles[index];

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
              },
              itemCount: articles.length,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  bool get _hasReachedMax {
    return (_articlesBloc.currentState as ArticlesLoaded).hasReachedMax;
  }

  bool get _isAtBottom {
    final scrollPosition = widget.scrollController.position;

    return scrollPosition.atEdge &&
        scrollPosition.userScrollDirection == ScrollDirection.forward;
  }

  void _onScroll() {
    final maxScroll = _scrollMarker + widget.scrollThreshold;
    final currentScroll = widget.scrollController.position.pixels;
    if (_articlesBloc.currentState is ArticlesLoaded) {
      if (!_hasReachedMax && (currentScroll >= maxScroll || _isAtBottom)) {
        _scrollMarker = maxScroll;
        widget.onLoadMore(_articlesBloc);
      }
    }
  }

  Future<void> _onRefresh() async {
    widget.onRefresh(_articlesBloc);
  }
}

class FeedModel {
  final String id;
  final String label;
  final Function(ArticlesBloc bloc) onRefresh;
  final Function(ArticlesBloc bloc) onLoad;
  final Function(ArticlesBloc bloc) onLoadMore;
  final double scrollThreshold;
  final Widget child;
  FeedModel({
    @required this.id,
    @required this.label,
    this.onRefresh,
    this.onLoad,
    this.onLoadMore,
    this.child,
    this.scrollThreshold = 400.0,
  });
}
