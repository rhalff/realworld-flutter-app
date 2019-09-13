import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/new_article.dart';
import 'package:realworld_flutter/blocs/article/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/pages/article/new_article_form.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

import 'article.dart';

class NewArticleScreen extends StatefulWidget {
  static const String route = '/new_post';

  @override
  _NewArticleScreenState createState() => _NewArticleScreenState();
}

class _NewArticleScreenState extends State<NewArticleScreen> {
  ArticleBloc _articleBloc;

  @override
  void initState() {
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: ScrollPage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 12),
            BlocBuilder(
              bloc: _articleBloc,
              condition: (_, ArticleState state) {
                if (state is ArticleLoaded) {
                  Navigator.of(context).popAndPushNamed(
                    ArticleScreen.route,
                    arguments: {
                      'slug': state.article.slug,
                    },
                  );

                  return false;
                }

                return true;
              },
              builder: (BuildContext context, ArticleState state) {
                Object error;
                if (state is ArticleError) {
                  error = state.error;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: NewArticleForm(
                    onSave: _saveForm,
                    error: error.toString(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _saveForm(NewArticle article) {
    _articleBloc.dispatch(
      CreateArticleEvent(
        article: article,
      ),
    );

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: const Text('Processing Data')));
  }
}
