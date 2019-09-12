import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:realworld_flutter/api/model/new_comment.dart';
import 'package:realworld_flutter/blocs/article/bloc.dart';
import 'package:realworld_flutter/blocs/articles/bloc.dart';
import 'package:realworld_flutter/blocs/user/bloc.dart';
import 'package:realworld_flutter/layout.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/comment.dart';
import 'package:realworld_flutter/model/user.dart';
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
  ArticlesBloc _articlesBloc;
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _articlesBloc = BlocProvider.of<ArticlesBloc>(context);
    _articleBloc = BlocProvider.of<ArticleBloc>(context)
      ..dispatch(LoadArticleEvent(slug: widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        final actions = <Widget>[];
        Widget child;
        if (state is ArticleError) {
          child = ErrorContainer(
            error: 'failed to load article',
          );
        } else if (state is ArticleLoaded) {
          child = BlocBuilder(
            bloc: _userBloc,
            builder: (BuildContext context, UserState userState) {
              final user = userState is UserLoaded ? userState.user : null;

              actions.addAll(
                <Widget>[
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
              return ArticlePage(
                user: user,
                article: state.article,
                comments: state.comments,
                postComment: (String comment) {
                  _articleBloc.dispatch(
                    CreateCommentEvent(
                      slug: state.article.slug,
                      comment: NewComment(body: comment),
                    ),
                  );
                },
                removeComment: (int id) {
                  _articleBloc.dispatch(
                    DeleteCommentEvent(
                      id: id,
                      slug: state.article.slug,
                    ),
                  );
                },
              );
            },
          );
        } else {
          child = Center(
            child: const CircularProgressIndicator(),
          );
        }

        return Layout(
          child: child,
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
    _articlesBloc.dispatch(ToggleFavoriteEvent(slug: slug));
  }

  void _shareArticle() {}

  void _search() {}
}

class ArticlePage extends StatelessWidget {
  final User user;
  final Article article;
  final List<Comment> comments;
  final Function(String comment) postComment;
  final Function(int id) removeComment;
  const ArticlePage({
    this.user,
    this.article,
    this.comments,
    this.postComment,
    this.removeComment,
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
                user != null
                    ? ArticleForm(
                        avatar: null,
                        onSubmit: postComment,
                      )
                    : Container(
                        child: const Text('Please login'),
                      ),
                ArticleComments(
                  user: user,
                  comments: comments,
                  onRemove: removeComment,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ArticleForm extends StatefulWidget {
  final String avatar;
  final Function(String comment) onSubmit;
  ArticleForm({
    Key key,
    this.avatar,
    this.onSubmit,
  }) : super(key: key);

  @override
  _ArticleFormState createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  String _comment;

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
                onChanged: (String value) {
                  setState(() {
                    _comment = value;
                  });
                }),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0XFFF5F5F5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ArticleMeta(
                    avatar: widget.avatar,
                  ),
                  RoundedButton(
                    text: 'Post Comment',
                    onPressed: _comment != null ? _onSubmit : null,
                  )
                ],
              ))
        ],
      ),
    );
  }

  void _onSubmit() {
    if (widget.onSubmit != null) {
      widget.onSubmit(_comment);
    }
  }
}

class ArticleComment extends StatelessWidget {
  final Comment comment;
  final Function(int id) onRemove;
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
  final User user;
  final List<Comment> comments;
  final Function(int id) onRemove;

  ArticleComments({
    Key key,
    this.user,
    this.comments,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: comments.map(
      (Comment comment) {
        return Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ArticleComment(
            comment: comment,
            onRemove: onRemove,
          ),
        );
      },
    ).toList());
  }
}
