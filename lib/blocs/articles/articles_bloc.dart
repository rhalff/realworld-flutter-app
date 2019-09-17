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
    if (currentState is ArticlesLoaded) {
      final state = currentState as ArticlesLoaded;

      if (event is ArticleCreatedEvent ||
          event is ArticleDeletedEvent ||
          event is ArticleUpdatedEvent) {
        dispatch(ReloadArticlesEvent());
      }

      if (event is FavoriteCreatedEvent) {
        _updateIfArticleInList(state.articles, event.article);
      } else if (event is FavoriteDeletedEvent) {
        _updateIfArticleInList(state.articles, event.article);
      }
    }
  }

  void _updateIfArticleInList(List<Article> articles, Article article) {
    for (var _article in articles) {
      if (_article.slug == article.slug) {
        dispatch(
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
      (events as Observable<ArticlesEvent>).debounceTime(
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
    } else if (event is ToggleFavoriteEvent) {
      yield* _toggleFavorite(event);
    } else if (event is UpdateArticleInListEvent) {
      yield* _updateArticleInList(event);
    }
  }

  Stream<ArticlesState> _updateArticleInList(
      UpdateArticleInListEvent event) async* {
    if (currentState is ArticlesLoaded) {
      final state = currentState as ArticlesLoaded;
      final reloadEvent = _eventForReload as LoadArticlesEvent;

      final articles = <Article>[];

      if (state.feedType == FeedType.globalFeed &&
          reloadEvent.favorited != null) {
        var exists = false;
        for (var article in state.articles) {
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
        for (var article in state.articles) {
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
        state.feedType,
        articles,
        state.hasReachedMax,
      );
    }
  }

  bool _hasReachedMax() =>
      currentState is ArticlesLoaded &&
      (currentState as ArticlesLoaded).hasReachedMax;

  Stream<ArticlesState> _loadArticles(LoadArticlesEvent event) async* {
    try {
      if (currentState is ArticlesUninitialized ||
          (currentState is ArticlesLoaded &&
              (currentState as ArticlesLoaded).feedType !=
                  FeedType.globalFeed) ||
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
      } else if (currentState is ArticlesLoaded) {
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
      if (currentState is ArticlesUninitialized ||
          (currentState is ArticlesLoaded &&
              (currentState as ArticlesLoaded).feedType != FeedType.userFeed) ||
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
      } else if (currentState is ArticlesLoaded) {
        final loadedArticles = currentState as ArticlesLoaded;

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

      dispatch(_eventForReload);
    }
  }

  Stream<ArticlesState> _toggleFavorite(ToggleFavoriteEvent event) async* {
    try {
      if (currentState is ArticlesLoaded) {
        var favorited = false;

        final articles = (currentState as ArticlesLoaded).articles.map((item) {
          if (item.slug == event.slug) {
            favorited = !item.favorited;
            final favoritesCount =
                favorited ? item.favoritesCount + 1 : item.favoritesCount - 1;

            return item.copyWith(
              favorited: favorited,
              favoritesCount: favoritesCount,
            );
          }

          return item;
        }).toList();

        if (favorited) {
          await articlesRepository.createFavorite(event.slug);
        } else {
          await articlesRepository.deleteArticleFavorite(event.slug);
        }

        yield ArticlesLoaded(
          (currentState as ArticlesLoaded).feedType,
          articles,
          false,
        );
      }
    } catch (error) {
      print(error);
      yield ArticlesError('Failed to load articles');
    }
  }

  @override
  void dispose() {
    _articlesRepositorySubscription.cancel();
    super.dispose();
  }
}
