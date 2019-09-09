import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/repositories/articles_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'articles_events.dart';
import 'articles_state.dart';

const _itemsPerRequest = 20;

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository articlesRepository;

  ArticlesBloc({
    @required this.articlesRepository,
  }) : assert(articlesRepository != null);

  @override
  Stream<ArticlesState> transformEvents(
    Stream<ArticlesEvent> events,
    Stream<ArticlesState> Function(ArticlesEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<ArticlesEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  ArticlesState get initialState => ArticlesUninitialized();

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    if (!_hasReachedMax()) {
      if (event is LoadArticles) {
        yield* _loadArticles(event);
      } else if (event is LoadArticlesFeed) {
        yield* _loadArticlesFeed(event);
      }
    }
  }

  bool _hasReachedMax() =>
      currentState is ArticlesLoaded &&
      (currentState as ArticlesLoaded).hasReachedMax;

  Stream<ArticlesState> _loadArticles(LoadArticles event) async* {
    try {
      if (currentState is ArticlesUninitialized || event.refresh) {
        final result = await articlesRepository.getArticles(
          // solve switching of tag, author and favorited later.
          tag: event.tag,
          author: event.author,
          favorited: event.favorited,
          limit: _itemsPerRequest,
          offset: 0,
        );

        yield ArticlesLoaded(result.articles, false);

        return;
      }

      if (currentState is ArticlesLoaded) {
        final loadedArticles = currentState as ArticlesLoaded;

        final result = await articlesRepository.getArticles(
          tag: event.tag,
          author: event.author,
          favorited: event.favorited,
          limit: _itemsPerRequest,
          offset: loadedArticles.articles.length,
        );

        if (result.articles.isEmpty) {
          yield loadedArticles.copyWith(hasReachedMax: true);
        } else {
          yield ArticlesLoaded(
            loadedArticles.articles + result.articles,
            false,
          );
        }
      }
    } catch (error) {
      print(error);
      yield ArticlesError('Failed to load articles');
    }
  }

  Stream<ArticlesState> _loadArticlesFeed(LoadArticlesFeed event) async* {
    yield ArticlesLoading();

    try {
      final result = await articlesRepository.getArticlesFeed(
        limit: _itemsPerRequest,
        offset: 20,
      );

      yield ArticlesLoaded(result.articles, false);
    } catch (error) {
      print(error);
      yield ArticlesError('Failed to load articles');
    }
  }
}
