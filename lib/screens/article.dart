import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/article/bloc.dart';
import 'package:realworld_flutter/blocs/comments/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/localizations/rw_localizations.dart';
import 'package:realworld_flutter/pages/article/article_page.dart';
import 'package:realworld_flutter/repositories/articles/repository.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class ArticleScreen extends StatefulWidget {
  static const String route = '/article';

  final UserBloc userBloc;
  ArticleScreen({
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
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = RWLocalizations.of(context);
    final user = widget.userBloc.getCurrentUser();

    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        final actions = <Widget>[];
        Widget child;
        if (state is ArticleError) {
          child = ErrorContainer(
            error: locale.articleFailedToLoad,
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
          child = const Center(
            child: CircularProgressIndicator(),
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
              mainAxisAlignment: MainAxisAlignment.end,
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
}
