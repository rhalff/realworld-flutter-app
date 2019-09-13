import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/api/model/article_submission.dart';
import 'package:realworld_flutter/blocs/article/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/pages/article/article_form.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

import 'article.dart';

class ArticleEditorScreen extends StatefulWidget {
  static const String route = '/article_editor';

  final String slug;

  ArticleEditorScreen({
    this.slug,
  });

  @override
  _ArticleEditorScreenState createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  ArticleBloc _articleBloc;

  @override
  void initState() {
    _articleBloc = BlocProvider.of<ArticleBloc>(context);

    if (widget.slug != null) {
      _articleBloc.dispatch(LoadArticleEvent(slug: widget.slug));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _articleBloc,
      listener: (BuildContext context, ArticleState state) {
        if (state is ArticleSaved) {
          Navigator.of(context).popAndPushNamed(
            ArticleScreen.route,
            arguments: {
              'slug': state.article.slug,
            },
          );
        }
      },
      child: Layout(
        child: ScrollPage(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 12),
              BlocBuilder(
                bloc: _articleBloc,
                builder: (BuildContext context, ArticleState state) {
                  Object error;
                  Article article;
                  if (state is ArticleError) {
                    error = state.error;
                  } else if (state is ArticleLoading ||
                      (state is ArticleUninitialized && widget.slug != null)) {
                    return const CircularProgressIndicator();
                  } else if (state is ArticleLoaded) {
                    article = state.article;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ArticleForm(
                      article: article,
                      onSave: _saveForm,
                      error: error?.toString(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm(ArticleSubmission article) {
    if (widget.slug != null) {
      _articleBloc.dispatch(
        UpdateArticleEvent(
          slug: widget.slug,
          article: article,
        ),
      );
    } else {
      _articleBloc.dispatch(
        CreateArticleEvent(
          article: article,
        ),
      );
    }

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: const Text('Saving Article')));
  }
}
