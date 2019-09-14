import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/article/bloc.dart';
import 'package:realworld_flutter/blocs/comments/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/article/article_page.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class ArticleScreen extends StatefulWidget {
  static const String route = '/article';

  final String slug;
  final UserBloc userBloc;
  ArticleScreen({
    this.slug,
    this.userBloc,
  });

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _articleBloc = BlocProvider.of<ArticleBloc>(context)
      ..dispatch(LoadArticleEvent(slug: widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userBloc.getCurrentUser();

    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        final actions = <Widget>[];
        Widget child;
        if (state is ArticleError) {
          child = ErrorContainer(
            error: 'failed to load article',
          );
        } else if (state is ArticleLoaded) {
          actions.addAll(
            <Widget>[
              if (user != null)
                IconButton(
                  icon: state.article.favorited
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                  onPressed: () => _toggleFavorited(state.article.slug),
                ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: _shareArticle,
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _search,
              ),
            ],
          );

          child = MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<CommentsBloc>(
                builder: (BuildContext context) {
                  return CommentsBloc(
                    articlesRepository:
                        RepositoryProvider.of<ArticlesRepository>(context),
                  );
                },
              ),
            ],
            child: ArticlePage(
              user: user,
              article: state.article,
            ),
          );
        } else {
          child = Center(
            child: const CircularProgressIndicator(),
          );
        }

        return Layout(
          child: ScrollPage(
            child: child,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 4.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: actions,
            ),
          ),
        );
      },
    );
  }

  void _toggleFavorited(String slug) {
    _articleBloc.dispatch(ToggleFavoriteEvent(slug: slug));
  }

  void _shareArticle() {}

  void _search() {}
}
