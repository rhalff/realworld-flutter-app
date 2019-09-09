import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:realworld_flutter/blocs/article/article_bloc.dart';
import 'package:realworld_flutter/blocs/article/article_events.dart';
import 'package:realworld_flutter/blocs/article/article_state.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/comment.dart';
import 'package:realworld_flutter/widgets/article_meta.dart';
import 'package:realworld_flutter/widgets/error_container.dart';
import 'package:realworld_flutter/widgets/header.dart';
import 'package:realworld_flutter/widgets/rounded_button.dart';
import 'package:realworld_flutter/widgets/scroll_page.dart';

class ArticleScreen extends StatefulWidget {
  static const String route = '/article';

  final String slug;
  ArticleScreen({
    this.slug,
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
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        Widget child;
        if (state is ArticleError) {
          child = ErrorContainer(
            error: 'failed to load article',
          );
        } else if (state is ArticleLoaded) {
          child = ArticlePage(
            article: state.article,
            comments: state.comments,
          );
        } else {
          child = Center(
            child: const CircularProgressIndicator(),
          );
        }

        return Layout(child: child);
      },
    );
  }
}

class ArticlePage extends StatelessWidget {
  final Article article;
  final List<Comment> comments;
  const ArticlePage({
    this.article,
    this.comments,
  });
  @override
  Widget build(BuildContext context) {
    return ScrollPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Header(
            title: article.title,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.only(
              bottom: 18,
              left: 18,
              right: 18,
            ),
            color: const Color(0XFF3333333),
            child: ArticleMeta(
              avatar: article.author.image,
              author: article.author.username,
              date: article.createdAt,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: MarkdownBody(data: article.body),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                ArticleForm(
                  // ok now actually need to know the logged in user
                  avatar: null,
                  onSubmit: _postComment,
                ),
                ArticleComments(
                  comments: comments,
                  onRemove: _removeComment,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _removeComment(String id) {}
  void _postComment() {}
}

class ArticleForm extends StatelessWidget {
  final String avatar;
  final VoidCallback onSubmit;
  ArticleForm({
    Key key,
    this.avatar,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                contentPadding: const EdgeInsets.all(14),
              ),
              minLines: 2,
              maxLines: 10,
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0XFFF5F5F5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ArticleMeta(
                    avatar: avatar,
                  ),
                  RoundedButton(
                    text: 'Post Comment',
                    onPressed: onSubmit,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class ArticleComment extends StatelessWidget {
  final Comment comment;
  final Function(String id) onRemove;
  ArticleComment({
    Key key,
    this.comment,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFFE5E5E5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(comment.body),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0XFFF5F5F5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ArticleMeta(
                    author: comment.author.username,
                    date: comment.createdAt,
                    avatar: comment.author.image,
                  ),
                  if (onRemove != null)
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.delete),
                    )
                ],
              ))
        ],
      ),
    );
  }
}

@immutable
class ArticleComments extends StatelessWidget {
  final List<Comment> comments;
  final Function(String id) onRemove;

  ArticleComments({
    Key key,
    this.comments,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: comments.map((Comment comment) {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: ArticleComment(
          comment: comment,
          onRemove: onRemove,
        ),
      );
    }).toList());
  }
}
