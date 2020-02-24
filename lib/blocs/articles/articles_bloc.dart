part of blocs.articles;

const _itemsPerRequest = 20;

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository articlesRepository;
  ArticlesEvent _eventForReload;
  StreamSubscription _articlesRepositorySubscription;

  ArticlesBloc({
    @required this.articlesRepository,
  }) {
    assert(articlesRepository != null);

    _articlesRepositorySubscription =
        articlesRepository.on<ArticleRepositoryEvent>().listen(_reloadHandler);
  }

  void _reloadHandler(ArticleRepositoryEvent event) {
    if (state is ArticlesLoaded) {
      final currentState = state as ArticlesLoaded;

      if (event is ArticleCreatedEvent ||
          event is ArticleDeletedEvent ||
          event is ArticleUpdatedEvent) {
        add(ReloadArticlesEvent());
      }

      if (event is FavoriteCreatedEvent) {
        _updateIfArticleInList(currentState.articles, event.article);
      } else if (event is FavoriteDeletedEvent) {
        _updateIfArticleInList(currentState.articles, event.article);
      }
    }
  }

  void _updateIfArticleInList(List<Article> articles, Article article) {
    for (var _article in articles) {
      if (_article.slug == article.slug) {
        add(
          UpdateArticleInListEvent(
            article: article,
          ),
        );
      }
    }
  }

  @override
  Stream<ArticlesState> transformEvents(
    Stream<ArticlesEvent> events,
    Stream<ArticlesState> Function(ArticlesEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        const Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  ArticlesState get initialState => ArticlesUninitialized();

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    if (event is LoadArticlesEvent && !_hasReachedMax()) {
      yield* _loadArticles(event);
    } else if (event is LoadArticlesFeedEvent && !_hasReachedMax()) {
      yield* _loadArticlesFeed(event);
    } else if (event is ReloadArticlesEvent) {
      yield* _reloadArticles(event);
    } else if (event is UpdateArticleInListEvent) {
      yield* _updateArticleInList(event);
    }
  }

  Stream<ArticlesState> _updateArticleInList(
      UpdateArticleInListEvent event) async* {
    if (state is ArticlesLoaded) {
      final currentState = state as ArticlesLoaded;

      final articles = <Article>[];

      if (currentState.feedType == FeedType.globalFeed &&
          (_eventForReload as LoadArticlesEvent).favorited != null) {
        var exists = false;
        for (var article in currentState.articles) {
          if (article.slug != event.article.slug) {
            articles.add(article);
          } else {
            if (event.article.favorited) {
              articles.add(event.article);
            }
            exists = true;
          }
        }

        if (!exists) {
          if (event.article.favorited) {
            articles.add(event.article);
          }
        }
      } else {
        for (var article in currentState.articles) {
          if (article.slug == event.article.slug) {
            articles.add(
              article.copyWith(
                favorited: event.article.favorited,
                favoritesCount: event.article.favoritesCount,
              ),
            );
          } else {
            articles.add(article);
          }
        }
      }

      yield ArticlesLoaded(
        currentState.feedType,
        articles,
        currentState.hasReachedMax,
      );
    }
  }

  bool _hasReachedMax() =>
      state is ArticlesLoaded && (state as ArticlesLoaded).hasReachedMax;

  Stream<ArticlesState> _loadArticles(LoadArticlesEvent event) async* {
    try {
      if (state is ArticlesUninitialized ||
          (state is ArticlesLoaded &&
              (state as ArticlesLoaded).feedType != FeedType.globalFeed) ||
          event.refresh) {
        yield ArticlesUninitialized();

        final result = await articlesRepository.getArticles(
          tag: event.tag,
          author: event.author,
          favorited: event.favorited,
          limit: _itemsPerRequest,
          offset: 0,
        );

        yield ArticlesLoaded(
          FeedType.globalFeed,
          result.articles,
          false,
        );
      } else if (state is ArticlesLoaded) {
        final loadedArticles = state as ArticlesLoaded;

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
            FeedType.globalFeed,
            loadedArticles.articles + result.articles,
            false,
          );
        }
      }

      _eventForReload = event;
    } catch (error) {
      print(error);
      yield ArticlesError('Failed to load articles');
    }
  }

  Stream<ArticlesState> _loadArticlesFeed(LoadArticlesFeedEvent event) async* {
    try {
      if (state is ArticlesUninitialized ||
          (state is ArticlesLoaded &&
              (state as ArticlesLoaded).feedType != FeedType.userFeed) ||
          event.refresh) {
        yield ArticlesUninitialized();
        final result = await articlesRepository.getArticlesFeed(
          limit: _itemsPerRequest,
          offset: 0,
        );

        yield ArticlesLoaded(
          FeedType.userFeed,
          result.articles,
          false,
        );
      } else if (state is ArticlesLoaded) {
        final loadedArticles = state as ArticlesLoaded;

        final result = await articlesRepository.getArticlesFeed(
          limit: _itemsPerRequest,
          offset: loadedArticles.articles.length,
        );

        if (result.articles.isEmpty) {
          yield loadedArticles.copyWith(hasReachedMax: true);
        } else {
          yield ArticlesLoaded(
            FeedType.userFeed,
            loadedArticles.articles + result.articles,
            false,
          );
        }
      }

      _eventForReload = event;
    } catch (error) {
      print(error);
      yield ArticlesError('Failed to load articles');
    }
  }

  Stream<ArticlesState> _reloadArticles(ReloadArticlesEvent event) async* {
    if (_eventForReload != null) {
      yield ArticlesUninitialized();

      add(_eventForReload);
    }
  }

  @override
  Future<void> close() {
    _articlesRepositorySubscription.cancel();
    return super.close();
  }
}
