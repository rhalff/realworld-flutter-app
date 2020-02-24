part of blocs.article;

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticlesRepository articlesRepository;
  StreamSubscription _articlesRepositorySubscription;

  ArticleBloc({
    @required this.articlesRepository,
  }) {
    assert(articlesRepository != null);

    _articlesRepositorySubscription =
        articlesRepository.on<ArticleRepositoryEvent>().listen(_reloadHandler);
  }

  void _reloadHandler(ArticleRepositoryEvent event) {
    if (state is ArticleLoaded) {
      if (event is ArticleUpdatedEvent) {
        if (event.article.slug == (state as ArticleLoaded).article.slug) {
          add(
            LoadArticleEvent(slug: (state as ArticleLoaded).article.slug),
          );
        }
      }
    }
  }

  @override
  ArticleState get initialState => ArticleUninitialized();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is LoadArticleEvent) {
      yield* _loadArticle(event);
    } else if (event is CreateArticleEvent) {
      yield* _createArticle(event);
    } else if (event is UpdateArticleEvent) {
      yield* _updateArticle(event);
    } else if (event is DeleteArticleEvent) {
      yield* _deleteArticle(event);
    } else if (event is ToggleFavoriteEvent) {
      yield* _toggleFavorite(event);
    }
  }

  Stream<ArticleState> _loadArticle(LoadArticleEvent event) async* {
    try {
      yield ArticleLoading();
      final article = articlesRepository.getArticle(event.slug);

      yield ArticleLoaded(
        article: await article,
      );
    } catch (error) {
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _createArticle(CreateArticleEvent event) async* {
    try {
      yield ArticleLoading();
      final article = await articlesRepository.createArticle(event.article);

      yield ArticleSaved(
        article: article,
      );
    } catch (error) {
      print(error);
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _updateArticle(UpdateArticleEvent event) async* {
    try {
      yield ArticleLoading();

      await articlesRepository.updateArticle(
        event.slug,
        event.article,
      );

      if (event.onComplete != null) {
        event.onComplete();
      }

      /*
      yield ArticleSaved(
        article: article,
      );

      .add(ArticleUpdatedEvent());
       */
    } catch (error) {
      print(error);
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _deleteArticle(DeleteArticleEvent event) async* {
    try {
      yield ArticleLoading();
      await articlesRepository.deleteArticle(event.slug);

      event.onComplete();

      yield ArticleUninitialized();
    } catch (error) {
      yield ArticleError(error);
    }
  }

  Stream<ArticleState> _toggleFavorite(ToggleFavoriteEvent event) async* {
    try {
      if (state is ArticleLoaded) {
        Article article;

        if ((state as ArticleLoaded).article.favorited) {
          article = await articlesRepository.deleteArticleFavorite(event.slug);
        } else {
          article = await articlesRepository.createFavorite(event.slug);
        }

        yield ArticleLoaded(article: article);
      }
    } catch (error) {
      print(error);
      yield const ArticleError('Failed to favorite article');
    }
  }

  @override
  Future<void> close() {
    _articlesRepositorySubscription.cancel();
    return super.close();
  }
}
