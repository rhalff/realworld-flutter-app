import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';

import 'article_events.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticlesRepository articlesRepository;

  ArticleBloc({
    @required this.articlesRepository,
  }) {
    assert(articlesRepository != null);
  }

  @override
  ArticleState get initialState => ArticleUninitialized();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is LoadArticleEvent) {
      yield* _loadArticle(event);
    } else if (event is CreateArticleEvent) {
      yield* _createArticle(event);
    } else if (event is DeleteArticleEvent) {
      yield* _deleteArticle(event);
    } else if (event is CreateCommentEvent) {
      yield* _createComment(event);
    } else if (event is DeleteCommentEvent) {
      yield* _deleteComment(event);
    }
  }

  Stream<ArticleState> _loadArticle(LoadArticleEvent event) async* {
    try {
      yield ArticleLoading();
      final article = articlesRepository.getArticle(event.slug);
      final comments = articlesRepository.getComments(event.slug);

      yield ArticleLoaded(
        article: await article,
        comments: await comments,
      );
    } catch (error) {
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _createArticle(CreateArticleEvent event) async* {
    try {
      yield ArticleLoading();
      final article = await articlesRepository.createArticle(event.article);

      yield ArticleLoaded(
        article: article,
      );
    } catch (error) {
      print(error);
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _deleteArticle(DeleteArticleEvent event) async* {
    try {
      yield ArticleLoading();
      await articlesRepository.deleteArticle(event.slug);

      yield ArticleUninitialized();
    } catch (error) {
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _createComment(CreateCommentEvent event) async* {
    try {
      yield ArticleLoading();
      await articlesRepository.createComment(event.slug, event.comment);

      dispatch(
        LoadArticleEvent(
          slug: event.slug,
        ),
      );
    } catch (error) {
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _deleteComment(DeleteCommentEvent event) async* {
    try {
      yield ArticleLoading();
      await articlesRepository.deleteComment(event.slug, event.id);

      dispatch(
        LoadArticleEvent(
          slug: event.slug,
        ),
      );
    } catch (error) {
      yield ArticleError(error);
    }
  }
}
