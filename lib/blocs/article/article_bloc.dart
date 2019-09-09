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
}
