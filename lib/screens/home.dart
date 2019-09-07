import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/articles/articles_bloc.dart';
import 'package:realworld_flutter/blocs/articles/articles_events.dart';
import 'package:realworld_flutter/blocs/articles/articles_state.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/widgets/banner.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/preview_post.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Banner(),
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
                    Tab(text: 'Your Feed'),
                    Tab(text: 'Global Feed'),
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
  final _scrollThreshold = 200.0;
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
              child: Text('no articles'),
            );
          }

          final itemCount =
              state.hasReachedMax ? articles.length : articles.length + 1;

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= articles.length
                  ? BottomLoader()
                  : ArticleWidget(article: articles[index]);
            },
            itemCount: itemCount,
            // controller: _scrollController,
          );
        }
        return Center(
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
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _articlesBloc.dispatch(LoadArticles());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
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
    /*
    PreviewArticles(
      author: 'Eric Simons',
      avatar: '',
      date: DateTime.now(),
      title: 'How to build webapps that scale',
      text:
      "In my demo, the holy grail layout is nested inside a document, so there's no body or main tags like shown above. Regardles, we're interested in the class names and the appearance of sections in the markup as opposed to the actual elements themselves. In particular, take note of the modifier classes used on the two sidebars, and the trivial order in which they appear in the markup. Let's break this down to paint a clear picture of what's happening...",
    ),
    */
    return PreviewPost(
      author: article.author.username,
      avatar: article.author.image,
      date: article.createdAt,
      title: article.title,
      text: article.description,
      favorited: article.favorited,
      favorites: article.favoritesCount,
    );
    /*
    return ListTile(
      leading: Text(
        '${article.slug}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(article.title),
      isThreeLine: true,
      subtitle: Text(article.body),
      dense: true,
    );
     */
  }
}
