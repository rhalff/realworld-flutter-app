part of blocs.articles;

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
    if (event is LoadArticlesEvent && !_hasReachedMax()) {
      yield* _loadArticles(event);
    } else if (event is LoadArticlesFeedEvent && !_hasReachedMax()) {
      yield* _loadArticlesFeed(event);
    } else if (event is ToggleFavoriteEvent) {
      yield* _toggleFavorite(event);
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
            FeedType.globalFeed,
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

        return;
      }

      if (currentState is ArticlesLoaded) {
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
    } catch (error) {
      print(error);
      yield ArticlesError('Failed to load articles');
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
}
