part of blocs.article;

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
    } else if (event is ToggleFavoriteEvent) {
      yield* _toggleFavorite(event);
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

  Stream<ArticleState> _toggleFavorite(ToggleFavoriteEvent event) async* {
    try {
      if (currentState is ArticleLoaded) {
        Article article;

        if ((currentState as ArticleLoaded).article.favorited) {
          article = await articlesRepository.deleteArticleFavorite(event.slug);
        } else {
          article = await articlesRepository.createFavorite(event.slug);
        }

        yield ArticleLoaded(article: article);
      }
    } catch (error) {
      print(error);
      yield ArticleError('Failed to favorite article');
    }
  }
}
