import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:realworld_flutter/api/model/new_comment.dart';
import 'package:realworld_flutter/blocs/comments/bloc.dart';
import 'package:realworld_flutter/model/article.dart';
import 'package:realworld_flutter/model/user.dart';
import 'package:realworld_flutter/widgets/drop_down_menu.dart';

import 'article_comment_form.dart';
import 'article_comments.dart';
import 'article_header.dart';

class ArticlePage extends StatefulWidget {
  final User user;
  final Article article;
  const ArticlePage({
    this.user,
    this.article,
  });

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  CommentsBloc _commentsBloc;
  @override
  void didChangeDependencies() {
    _commentsBloc = BlocProvider.of<CommentsBloc>(context)
      ..dispatch(
        LoadCommentsEvent(slug: widget.article.slug),
      );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            ArticleHeader(article: widget.article),
            if (widget.article.author.username == widget.user.username)
              Positioned(
                top: 10,
                right: 10,
                child: DropdownMenu(
                  items: [
                    MenuItem(
                      id: 'edit-article',
                      label: 'Edit article',
                      icon: Icons.edit,
                    ),
                  ],
                ),
              ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14),
                child: MarkdownBody(data: widget.article.body),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              widget.user != null
                  ? ArticleCommentForm(
                      avatar: widget.user.image,
                      onSubmit: (String comment) {
                        _commentsBloc.dispatch(
                          CreateCommentEvent(
                            slug: widget.article.slug,
                            comment: NewComment(body: comment),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: const Text('Please login'),
                    ),
              BlocBuilder<CommentsBloc, CommentsState>(
                builder: (
                  BuildContext context,
                  CommentsState state,
                ) {
                  if (state is CommentsLoaded) {
                    return ArticleComments(
                      user: widget.user,
                      comments: state.comments,
                      onRemove: (int id) {
                        _commentsBloc.dispatch(
                          DeleteCommentEvent(
                            id: id,
                            slug: widget.article.slug,
                          ),
                        );
                      },
                    );
                  }

                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
